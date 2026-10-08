const Competitor = @import("competitor.zig").Competitor;

/// Contains information about one fixture. It is used in the SearchFixtures
/// response.
///
/// Elemental Inference relays the information in this structure from the data
/// source, so that you can identify the fixture that matches your source media.
pub const FixtureSummary = struct {
    /// An array of the competitors (the teams or individuals) in the fixture.
    competitors: []const Competitor,

    /// The group that the fixture belongs to, such as the competition, league, or
    /// tournament. The data source doesn't provide this information for every
    /// fixture.
    fixture_group: ?[]const u8 = null,

    /// The ID of the fixture. Specify this ID in the clipping output of a feed, to
    /// identify the fixture whose event data you want Elemental Inference to map
    /// onto the clipping metadata.
    fixture_id: []const u8,

    /// The name of the fixture, as provided by the data source. For example, the
    /// names of the two competing teams.
    name: []const u8,

    /// The scheduled start time of the fixture, as provided by the data source. The
    /// actual start time might differ.
    scheduled_start: ?i64 = null,

    /// The status of the fixture in its lifecycle, as provided by the data source.
    /// For example, Scheduled or Completed.
    status: []const u8,

    pub const json_field_names = .{
        .competitors = "competitors",
        .fixture_group = "fixtureGroup",
        .fixture_id = "fixtureId",
        .name = "name",
        .scheduled_start = "scheduledStart",
        .status = "status",
    };
};
