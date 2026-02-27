/// The SQL DataIntegrationFlow transformation configuration parameters.
pub const DataIntegrationFlowSQLTransformationConfiguration = struct {
    /// The transformation SQL query body based on SparkSQL.
    query: []const u8,

    pub const json_field_names = .{
        .query = "query",
    };
};
