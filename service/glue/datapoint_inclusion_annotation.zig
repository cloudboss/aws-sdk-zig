const InclusionAnnotationValue = @import("inclusion_annotation_value.zig").InclusionAnnotationValue;

/// An Inclusion Annotation.
pub const DatapointInclusionAnnotation = struct {
    /// The inclusion annotation value to apply to the statistic.
    inclusion_annotation: ?InclusionAnnotationValue,

    /// The ID of the data quality profile the statistic belongs to.
    profile_id: ?[]const u8,

    /// The Statistic ID.
    statistic_id: ?[]const u8,

    pub const json_field_names = .{
        .inclusion_annotation = "InclusionAnnotation",
        .profile_id = "ProfileId",
        .statistic_id = "StatisticId",
    };
};
