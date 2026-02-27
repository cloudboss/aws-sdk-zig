const LabelDetectionAggregateBy = @import("label_detection_aggregate_by.zig").LabelDetectionAggregateBy;
const LabelDetectionSortBy = @import("label_detection_sort_by.zig").LabelDetectionSortBy;

/// Contains metadata about a label detection request, including the SortBy and
/// AggregateBy
/// options.
pub const GetLabelDetectionRequestMetadata = struct {
    /// The aggregation method chosen for a GetLabelDetection request.
    aggregate_by: ?LabelDetectionAggregateBy,

    /// The sorting method chosen for a GetLabelDetection request.
    sort_by: ?LabelDetectionSortBy,

    pub const json_field_names = .{
        .aggregate_by = "AggregateBy",
        .sort_by = "SortBy",
    };
};
