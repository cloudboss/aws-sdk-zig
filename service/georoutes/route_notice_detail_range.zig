/// Notice Detail that is a range.
pub const RouteNoticeDetailRange = struct {
    /// Maximum value for the range.
    max: ?i32,

    /// Minimum value for the range.
    min: ?i32,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
