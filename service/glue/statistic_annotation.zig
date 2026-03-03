const TimestampedInclusionAnnotation = @import("timestamped_inclusion_annotation.zig").TimestampedInclusionAnnotation;

/// A Statistic Annotation.
pub const StatisticAnnotation = struct {
    /// The inclusion annotation applied to the statistic.
    inclusion_annotation: ?TimestampedInclusionAnnotation = null,

    /// The Profile ID.
    profile_id: ?[]const u8 = null,

    /// The Statistic ID.
    statistic_id: ?[]const u8 = null,

    /// The timestamp when the annotated statistic was recorded.
    statistic_recorded_on: ?i64 = null,

    pub const json_field_names = .{
        .inclusion_annotation = "InclusionAnnotation",
        .profile_id = "ProfileId",
        .statistic_id = "StatisticId",
        .statistic_recorded_on = "StatisticRecordedOn",
    };
};
