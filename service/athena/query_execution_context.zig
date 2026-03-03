/// The database and data catalog context in which the query execution occurs.
pub const QueryExecutionContext = struct {
    /// The name of the data catalog used in the query execution.
    catalog: ?[]const u8 = null,

    /// The name of the database used in the query execution. The database must
    /// exist in the
    /// catalog.
    database: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .database = "Database",
    };
};
