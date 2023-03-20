require 'spec_helper'
require 'timecop'

RSpec.describe Blockfrostruby::Webhooks do
  describe "#verify_webhook_signature" do
    let(:test_class) { Class.new { include Blockfrostruby::Webhooks }.send(:new) }
    let(:signed_at) { Time.at(1650013856) }
    let(:requested_at) { signed_at + 1 }
    let(:secret) { "59a1eb46-96f4-4f0b-8a03-b4d26e70593a" }
    let(:request_body) do
      '{"id":"47668401-c3a4-42d4-bac1-ad46515924a3","webhook_id":"cf68eb9c-635f-415e-a5a8-6233638f28d7","created":1650013856,"type":"block","payload":{"time":1650013853,"height":7126256,"hash":"f49521b67b440e5030adf124aee8f88881b7682ba07acf06c2781405b0f806a4","slot":58447562,"epoch":332,"epoch_slot":386762,"slot_leader":"pool1njjr0zn7uvydjy8067nprgwlyxqnznp9wgllfnag24nycgkda25","size":34617,"tx_count":13,"output":"13403118309871","fees":"4986390","block_vrf":"vrf_vk197w95j9alkwt8l4g7xkccknhn4pqwx65c5saxnn5ej3cpmps72msgpw69d","previous_block":"9e3f5bfc9f0be44cf6e14db9ed5f1efb6b637baff0ea1740bb6711786c724915","next_block":null,"confirmations":0}}'
    end

    subject do
      test_class.verify_webhook_signature(request_body, signature_header, secret)
    end

    before do
      Timecop.travel(requested_at)
    end

    context "with a valid signature" do
      let(:signature_header) do
        "t=1650013856,v1=f4c3bb2a8b0c8e21fa7d5fdada2ee87c9c6f6b0b159cc22e483146917e195c3e"
      end

      it "returns true" do
        expect(subject).to eq(true)
      end

      context "and timestamp out of tolerance zone" do
        let(:requested_at) { signed_at + 7200 }

        it "throws verification error" do
          expect { subject }.to raise_error(Blockfrostruby::Webhooks::SignatureVerificationError)
        end
      end
    end

    context "with two signatures, one valid and one invalid" do
      let(:signature_header) do
        "t=1650013856,v1=abc,v1=f4c3bb2a8b0c8e21fa7d5fdada2ee87c9c6f6b0b159cc22e483146917e195c3e"
      end

      it "returns true" do
        expect(subject).to eq(true)
      end
    end

    context "with missing timestamp in signature" do
      let(:signature_header) do
        "v1=f4c3bb2a8b0c8e21fa7d5fdada2ee87c9c6f6b0b159cc22e483146917e195c3e"
      end

      it "throws verification error" do
        expect { subject }.to raise_error(Blockfrostruby::Webhooks::SignatureVerificationError)
      end
    end

    context "with unsupported signature version" do
      let(:signature_header) do
        "t=1650013856,v42=abc"
      end

      it "throws verification error" do
        expect { subject }.to raise_error(Blockfrostruby::Webhooks::SignatureVerificationError)
      end
    end

    context "with no signature matching" do
      let(:signature_header) do
        "t=1650013856,v1=abc"
      end

      it "throws verification error" do
        expect { subject }.to raise_error(Blockfrostruby::Webhooks::SignatureVerificationError)
      end
    end
  end
end
