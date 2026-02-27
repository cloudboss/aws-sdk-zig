/// Represents a single entry in the list of values for `SqlAliases`.
pub const SqlAlias = struct {
    /// A temporary name given to a table, or a column in a table.
    alias: []const u8,

    /// A table, or a column in a table.
    from: []const u8,

    pub const json_field_names = .{
        .alias = "Alias",
        .from = "From",
    };
};
