/// Specifies an Glue Data Catalog target.
pub const CatalogTarget = struct {
    /// The name of the connection for an Amazon S3-backed Data Catalog table to be
    /// a target of the crawl when using a `Catalog` connection type paired with a
    /// `NETWORK` Connection type.
    connection_name: ?[]const u8 = null,

    /// The name of the database to be synchronized.
    database_name: []const u8,

    /// A valid Amazon dead-letter SQS ARN. For example,
    /// `arn:aws:sqs:region:account:deadLetterQueue`.
    dlq_event_queue_arn: ?[]const u8 = null,

    /// A valid Amazon SQS ARN. For example, `arn:aws:sqs:region:account:sqs`.
    event_queue_arn: ?[]const u8 = null,

    /// A list of the tables to be synchronized.
    tables: []const []const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .database_name = "DatabaseName",
        .dlq_event_queue_arn = "DlqEventQueueArn",
        .event_queue_arn = "EventQueueArn",
        .tables = "Tables",
    };
};
