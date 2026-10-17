const aws = @import("aws");

const DataSource = @import("data_source.zig").DataSource;

/// Describes a data quality result returned by `ListDataQualityResultsV2`.
pub const DataQualityResultsV2Description = struct {
    /// The table associated with the data quality result, if any.
    data_source: ?DataSource = null,

    /// A map of user-provided descriptors that add contextual metadata and
    /// configuration to the data quality result, such as database name, table name,
    /// team, or environment.
    descriptors: ?[]const aws.map.StringMapEntry = null,

    /// A map of platform-specific identifiers, such as cluster, application,
    /// workgroup, or project IDs, that identify where the data quality evaluation
    /// ran.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// The evaluation context for the data quality result. This value identifies a
    /// specific data quality result, or a series of related results, within a run.
    evaluation_context: ?[]const u8 = null,

    /// The unique result ID for this data quality result.
    result_id: ?[]const u8 = null,

    /// The date and time when this data quality result was published.
    result_published_on: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .descriptors = "Descriptors",
        .dimensions = "Dimensions",
        .evaluation_context = "EvaluationContext",
        .result_id = "ResultId",
        .result_published_on = "ResultPublishedOn",
    };
};
