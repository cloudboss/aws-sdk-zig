/// A failed annotation.
pub const AnnotationError = struct {
    /// The reason why the annotation failed.
    failure_reason: ?[]const u8,

    /// The Profile ID for the failed annotation.
    profile_id: ?[]const u8,

    /// The Statistic ID for the failed annotation.
    statistic_id: ?[]const u8,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .profile_id = "ProfileId",
        .statistic_id = "StatisticId",
    };
};
