/// This data type is used in the AssessmentTemplateFilter data
/// type.
pub const DurationRange = struct {
    /// The maximum value of the duration range. Must be less than or equal to
    /// 604800 seconds
    /// (1 week).
    max_seconds: ?i32,

    /// The minimum value of the duration range. Must be greater than zero.
    min_seconds: ?i32,

    pub const json_field_names = .{
        .max_seconds = "maxSeconds",
        .min_seconds = "minSeconds",
    };
};
