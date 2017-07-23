require "spec_helper"

RSpec.describe "Psych.simple_load" do

  let :yaml do
    %{
      message: Hello, worlds!
      colors:
        - babu
        - kazan
        - rausch
    }
  end

  it "should parse sample document" do
    document = Psych.simple_load(yaml)
    expect(document).to eq(
      'message' => 'Hello, worlds!',
      'colors' => %w(babu kazan rausch),
    )
  end

  it "should parse empty document" do
    document = Psych.simple_load("")
    expect(document).to eq nil
  end
end
