/// Specifies a target that uses Microsoft SQL.
pub const MicrosoftSQLServerCatalogTarget = struct {
    /// The name of the database to write to.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// The name of the table in the database to write to.
    table: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .table = "Table",
    };
};
