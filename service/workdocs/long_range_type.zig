/// Filter based on size (in bytes).
pub const LongRangeType = struct {
    /// The size end range (in bytes).
    end_value: ?i64,

    /// The size start range (in bytes).
    start_value: ?i64,

    pub const json_field_names = .{
        .end_value = "EndValue",
        .start_value = "StartValue",
    };
};
