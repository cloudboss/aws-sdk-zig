const aws = @import("aws");

const DataSource = @import("data_source.zig").DataSource;

/// Describes the criteria used to filter the data quality results returned by
/// `ListDataQualityResultsV2`.
pub const DataQualityResultsV2FilterCriteria = struct {
    /// The data source used to filter the results. For example, you can retrieve
    /// all results for an Glue table. `DatabaseName` and `TableName` are required.
    /// If you omit `CatalogId`, the catalog of the calling account is used.
    ///
    /// When you filter by data source, a page of results can be empty but still
    /// include a `NextToken`. Keep requesting pages until `NextToken` is absent.
    data_source: ?DataSource = null,

    /// The platform dimensions to filter results by.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// The evaluation context to filter results by.
    evaluation_context: ?[]const u8 = null,

    /// The time after which to include published results.
    published_after: ?i64 = null,

    /// The time before which to include published results.
    published_before: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .dimensions = "Dimensions",
        .evaluation_context = "EvaluationContext",
        .published_after = "PublishedAfter",
        .published_before = "PublishedBefore",
    };
};
