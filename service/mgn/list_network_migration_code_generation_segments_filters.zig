/// Filters for listing code generation segments.
pub const ListNetworkMigrationCodeGenerationSegmentsFilters = struct {
    /// A list of segment IDs to filter by.
    segment_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .segment_i_ds = "segmentIDs",
    };
};
