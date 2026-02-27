const IngestionJobFilterAttribute = @import("ingestion_job_filter_attribute.zig").IngestionJobFilterAttribute;
const IngestionJobFilterOperator = @import("ingestion_job_filter_operator.zig").IngestionJobFilterOperator;

/// The definition of a filter to filter the data.
pub const IngestionJobFilter = struct {
    /// The name of field or attribute to apply the filter.
    attribute: IngestionJobFilterAttribute,

    /// The operation to apply to the field or attribute.
    operator: IngestionJobFilterOperator,

    /// A list of values that belong to the field or attribute.
    values: []const []const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
        .operator = "operator",
        .values = "values",
    };
};
