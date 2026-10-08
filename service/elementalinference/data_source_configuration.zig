/// Contains the data source configuration for a clipping output. It identifies
/// the fixture whose event data Elemental Inference maps onto the clipping
/// metadata. It is used in the dataSourceConfiguration property of a
/// ClippingConfig.
pub const DataSourceConfiguration = struct {
    /// The ID of the fixture whose event data you want Elemental Inference to map
    /// onto this clipping output. The fixture should be the sports event in the
    /// source media that the feed is processing.
    ///
    /// To obtain this ID, use the SearchFixtures operation to find the fixture,
    /// then use the fixtureId from the matching FixtureSummary.
    fixture_id: []const u8,

    pub const json_field_names = .{
        .fixture_id = "fixtureId",
    };
};
