/// The properties of the SQL statement.
pub const StatementProperties = struct {
    /// The SQL text of the statement.
    definition: []const u8,

    pub const json_field_names = .{
        .definition = "Definition",
    };
};
