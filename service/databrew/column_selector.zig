/// Selector of a column from a dataset for profile job configuration.
/// One selector includes either a column name or a regular expression.
pub const ColumnSelector = struct {
    /// The name of a column from a dataset.
    name: ?[]const u8 = null,

    /// A regular expression for selecting a column from a dataset.
    regex: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .regex = "Regex",
    };
};
