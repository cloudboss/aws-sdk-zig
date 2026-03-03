/// Filters results based on timestamp range (in epochs).
pub const DateRangeType = struct {
    /// Timestamp range end value (in epochs).
    end_value: ?i64 = null,

    /// Timestamp range start value (in epochs)
    start_value: ?i64 = null,

    pub const json_field_names = .{
        .end_value = "EndValue",
        .start_value = "StartValue",
    };
};
