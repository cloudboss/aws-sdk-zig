/// Represents a single row in the query results.
pub const Row = struct {
    /// The data in a row of query results.
    row_data: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .row_data = "rowData",
    };
};
