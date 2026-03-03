/// The configurations for the Hive job driver.
pub const Hive = struct {
    /// The query file for the Hive job run.
    init_query_file: ?[]const u8 = null,

    /// The parameters for the Hive job run.
    parameters: ?[]const u8 = null,

    /// The query for the Hive job run.
    query: []const u8,

    pub const json_field_names = .{
        .init_query_file = "initQueryFile",
        .parameters = "parameters",
        .query = "query",
    };
};
