/// The column configuration of the asset filter.
pub const ColumnFilterConfiguration = struct {
    /// Specifies whether to include column names.
    included_column_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .included_column_names = "includedColumnNames",
    };
};
