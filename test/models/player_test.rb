require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  subject do
    Player.new(
      game: game,
      name: "Matt",
      seat_number: 1,
      faction: Faction.find_by_key(faction_key),
    )
  end
  let(:faction_key) { "l1z1x" }
  let(:game) { games(:one) }

  it "creates a valid player" do
    expect(subject.valid?).must_equal true
  end

  describe "Starting Tech" do
    let(:faction_key) { "arborec" }

    it "copies the correct player.technologies" do
      expect(subject.technologies).must_equal([
        Technology.find_by_key("magen_defense_grid")
      ])
    end

    describe "for a faction without starting technologies" do
      let(:faction_key) { "winnu" }

      it "sets no technologies" do
        expect(subject.technologies).must_equal([])
      end
    end
  end
end
