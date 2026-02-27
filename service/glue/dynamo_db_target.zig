/// Specifies an Amazon DynamoDB table to crawl.
pub const DynamoDBTarget = struct {
    /// The name of the DynamoDB table to crawl.
    path: ?[]const u8,

    /// Indicates whether to scan all the records, or to sample rows from the table.
    /// Scanning all the records can take a long time when the table is not a high
    /// throughput table.
    ///
    /// A value of `true` means to scan all records, while a value of `false` means
    /// to sample the records. If no value is specified, the value defaults to
    /// `true`.
    scan_all: ?bool,

    /// The percentage of the configured read capacity units to use by the Glue
    /// crawler. Read capacity units is a term defined by DynamoDB, and is a numeric
    /// value that acts as rate limiter for the number of reads that can be
    /// performed on that table per second.
    ///
    /// The valid values are null or a value between 0.1 to 1.5. A null value is
    /// used when user does not provide a value, and defaults to 0.5 of the
    /// configured Read Capacity Unit (for provisioned tables), or 0.25 of the max
    /// configured Read Capacity Unit (for tables using on-demand mode).
    scan_rate: ?f64,

    pub const json_field_names = .{
        .path = "Path",
        .scan_all = "scanAll",
        .scan_rate = "scanRate",
    };
};
