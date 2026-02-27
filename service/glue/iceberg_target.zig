/// Specifies an Apache Iceberg data source where Iceberg tables are stored in
/// Amazon S3.
pub const IcebergTarget = struct {
    /// The name of the connection to use to connect to the Iceberg target.
    connection_name: ?[]const u8,

    /// A list of glob patterns used to exclude from the crawl.
    /// For more information, see [Catalog Tables with a
    /// Crawler](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html).
    exclusions: ?[]const []const u8,

    /// The maximum depth of Amazon S3 paths that the crawler can traverse to
    /// discover the Iceberg metadata folder in your Amazon S3 path. Used to limit
    /// the crawler run time.
    maximum_traversal_depth: ?i32,

    /// One or more Amazon S3 paths that contains Iceberg metadata folders as
    /// `s3://bucket/prefix`.
    paths: ?[]const []const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .exclusions = "Exclusions",
        .maximum_traversal_depth = "MaximumTraversalDepth",
        .paths = "Paths",
    };
};
