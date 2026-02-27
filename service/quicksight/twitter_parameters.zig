/// The parameters for Twitter.
pub const TwitterParameters = struct {
    /// Maximum number of rows to query Twitter.
    max_rows: i32,

    /// Twitter query string.
    query: []const u8,

    pub const json_field_names = .{
        .max_rows = "MaxRows",
        .query = "Query",
    };
};
