/// Filters for listing mapper segment constructs.
pub const ListNetworkMigrationMapperSegmentConstructsFilters = struct {
    /// A list of construct IDs to filter by.
    construct_i_ds: ?[]const []const u8 = null,

    /// A list of construct types to filter by.
    construct_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .construct_i_ds = "constructIDs",
        .construct_types = "constructTypes",
    };
};
