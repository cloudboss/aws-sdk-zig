/// Contains information about one competitor in a fixture. It is used in the
/// FixtureSummary that is in the SearchFixtures response.
pub const Competitor = struct {
    /// Specifies whether this competitor is the home side in the fixture. If true,
    /// this competitor is the home side. If false, this competitor is the away
    /// side.
    is_home: ?bool = null,

    /// The name of the competitor, as provided by the data source.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_home = "isHome",
        .name = "name",
    };
};
