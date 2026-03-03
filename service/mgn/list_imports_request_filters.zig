/// List imports request filters.
pub const ListImportsRequestFilters = struct {
    /// List imports request filters import IDs.
    import_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .import_i_ds = "importIDs",
    };
};
