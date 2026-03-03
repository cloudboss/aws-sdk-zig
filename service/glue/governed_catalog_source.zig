const S3SourceAdditionalOptions = @import("s3_source_additional_options.zig").S3SourceAdditionalOptions;

/// Specifies the data store in the governed Glue Data Catalog.
pub const GovernedCatalogSource = struct {
    /// Specifies additional connection options.
    additional_options: ?S3SourceAdditionalOptions = null,

    /// The database to read from.
    database: []const u8,

    /// The name of the data store.
    name: []const u8,

    /// Partitions satisfying this predicate are deleted. Files within the retention
    /// period in these partitions are not deleted. Set to `""` – empty by default.
    partition_predicate: ?[]const u8 = null,

    /// The database table to read from.
    table: []const u8,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .database = "Database",
        .name = "Name",
        .partition_predicate = "PartitionPredicate",
        .table = "Table",
    };
};
