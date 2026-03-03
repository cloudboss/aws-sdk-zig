/// Specifies an Apache Hudi data source.
pub const HudiTarget = struct {
    /// The name of the connection to use to connect to the Hudi target. If your
    /// Hudi files are stored in buckets that require VPC authorization, you can set
    /// their connection properties here.
    connection_name: ?[]const u8 = null,

    /// A list of glob patterns used to exclude from the crawl.
    /// For more information, see [Catalog Tables with a
    /// Crawler](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html).
    exclusions: ?[]const []const u8 = null,

    /// The maximum depth of Amazon S3 paths that the crawler can traverse to
    /// discover the Hudi metadata folder in your Amazon S3 path. Used to limit the
    /// crawler run time.
    maximum_traversal_depth: ?i32 = null,

    /// An array of Amazon S3 location strings for Hudi, each indicating the root
    /// folder with which the metadata files for a Hudi table resides. The Hudi
    /// folder may be located in a child folder of the root folder.
    ///
    /// The crawler will scan all folders underneath a path for a Hudi folder.
    paths: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .exclusions = "Exclusions",
        .maximum_traversal_depth = "MaximumTraversalDepth",
        .paths = "Paths",
    };
};
