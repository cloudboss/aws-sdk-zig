const JdbcMetadataEntry = @import("jdbc_metadata_entry.zig").JdbcMetadataEntry;

/// Specifies a JDBC data store to crawl.
pub const JdbcTarget = struct {
    /// The name of the connection to use to connect to the JDBC target.
    connection_name: ?[]const u8 = null,

    /// Specify a value of `RAWTYPES` or `COMMENTS` to enable additional metadata in
    /// table responses. `RAWTYPES` provides the native-level datatype. `COMMENTS`
    /// provides comments associated with a column or table in the database.
    ///
    /// If you do not need additional metadata, keep the field empty.
    enable_additional_metadata: ?[]const JdbcMetadataEntry = null,

    /// A list of glob patterns used to exclude from the crawl.
    /// For more information, see [Catalog Tables with a
    /// Crawler](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html).
    exclusions: ?[]const []const u8 = null,

    /// The path of the JDBC target.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .enable_additional_metadata = "EnableAdditionalMetadata",
        .exclusions = "Exclusions",
        .path = "Path",
    };
};
