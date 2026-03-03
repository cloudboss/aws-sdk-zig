/// List exports request filters.
pub const ListExportsRequestFilters = struct {
    /// List exports request filters export ids.
    export_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .export_i_ds = "exportIDs",
    };
};
