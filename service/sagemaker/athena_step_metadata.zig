/// The query execution identifier and the result output location for the Amazon
/// Athena query that an Athena step runs.
pub const AthenaStepMetadata = struct {
    /// The unique identifier of the Amazon Athena query execution that was run by
    /// this step execution.
    query_execution_id: ?[]const u8 = null,

    /// The Amazon S3 location of the Amazon Athena query results. This is the
    /// effective output location reported by `GetQueryExecution` for the query.
    /// This value can be absent when the query uses Athena managed query results.
    s3_output_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_execution_id = "QueryExecutionId",
        .s3_output_location = "S3OutputLocation",
    };
};
