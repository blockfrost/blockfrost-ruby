module Blockfrostruby
  module Webhooks
    def verify_webhook_signature(request_body, signature_header, secret, timestamp_tolerance_seconds: 600)
      tokens = signature_header.split(",")
      signatures = []
      timestamp = nil

      tokens.each do |token|
        key, value = token.split("=")

        case key
        when "t"
          timestamp = value.to_i
        when "v1"
          signatures << value
        else
          puts "Cannot parse part of the Blockfrost-Signature header, key #{key} is not supported by this version of Blockfrost SDK. Please upgrade."
        end
      end

      if timestamp.nil? || tokens.length < 2
        # timestamp and at least one signature must be present
        raise SignatureVerificationError, "Invalid signature header format."
      end

      if signatures.length < 1
        # There are no signatures that this version of SDK supports
        raise SignatureVerificationError, "No signatures with supported version scheme."
      end

      # Recreate signature by concatenating the timestamp with the payload,
      # then compute HMAC using sha256 and provided secret (webhook auth token)
      signature_payload = "#{timestamp}.#{request_body}"
      local_signature = OpenSSL::HMAC.hexdigest("sha256", secret, signature_payload)

      has_valid_signature = false

      signatures.each do |signature|
        if secure_compare(signature, local_signature)
          has_valid_signature = true

          break
        end
      end

      unless has_valid_signature
        raise SignatureVerificationError, "No signature matches the expected signature for the payload."
      end

      if Time.now.utc.to_i - timestamp > timestamp_tolerance_seconds
        # Event is older than timestamp_tolerance_seconds
        raise SignatureVerificationError, "Signature's timestamp is outside of the time tolerance."
      else
        true
      end
    end

    # borrowed from ActiveSupport::SecurityUtils
    # https://github.com/rails/rails/blob/main/activesupport/lib/active_support/security_utils.rb
    if defined?(OpenSSL.fixed_length_secure_compare)
      def fixed_length_secure_compare(a, b)
        OpenSSL.fixed_length_secure_compare(a, b)
      end
    else
      def fixed_length_secure_compare(a, b)
        raise ArgumentError, "string length mismatch." unless a.bytesize == b.bytesize

        l = a.unpack "C#{a.bytesize}"

        res = 0
        b.each_byte { |byte| res |= byte ^ l.shift }
        res == 0
      end
    end

    def secure_compare(a, b)
      a.bytesize == b.bytesize && fixed_length_secure_compare(a, b)
    end

    class SignatureVerificationError < StandardError; end
  end
end
