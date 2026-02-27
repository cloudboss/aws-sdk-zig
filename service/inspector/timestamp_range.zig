/// This data type is used in the AssessmentRunFilter data
/// type.
pub const TimestampRange = struct {
    /// The minimum value of the timestamp range.
    begin_date: ?i64,

    /// The maximum value of the timestamp range.
    end_date: ?i64,

    pub const json_field_names = .{
        .begin_date = "beginDate",
        .end_date = "endDate",
    };
};
