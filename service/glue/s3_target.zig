/// Specifies a data store in Amazon Simple Storage Service (Amazon S3).
pub const S3Target = struct {
    /// The name of a connection which allows a job or crawler to access data in
    /// Amazon S3 within an Amazon Virtual Private Cloud environment (Amazon VPC).
    connection_name: ?[]const u8 = null,

    /// A valid Amazon dead-letter SQS ARN. For example,
    /// `arn:aws:sqs:region:account:deadLetterQueue`.
    dlq_event_queue_arn: ?[]const u8 = null,

    /// A valid Amazon SQS ARN. For example, `arn:aws:sqs:region:account:sqs`.
    event_queue_arn: ?[]const u8 = null,

    /// A list of glob patterns used to exclude from the crawl.
    /// For more information, see [Catalog Tables with a
    /// Crawler](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html).
    exclusions: ?[]const []const u8 = null,

    /// The path to the Amazon S3 target.
    path: ?[]const u8 = null,

    /// Sets the number of files in each leaf folder to be crawled when crawling
    /// sample files in a dataset. If not set, all the files are crawled. A valid
    /// value is an integer between 1 and 249.
    sample_size: ?i32 = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .dlq_event_queue_arn = "DlqEventQueueArn",
        .event_queue_arn = "EventQueueArn",
        .exclusions = "Exclusions",
        .path = "Path",
        .sample_size = "SampleSize",
    };
};
