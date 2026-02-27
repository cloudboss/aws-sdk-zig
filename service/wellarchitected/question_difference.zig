const DifferenceStatus = @import("difference_status.zig").DifferenceStatus;

/// A question difference return object.
pub const QuestionDifference = struct {
    /// Indicates the type of change to the question.
    difference_status: ?DifferenceStatus,

    question_id: ?[]const u8,

    question_title: ?[]const u8,

    pub const json_field_names = .{
        .difference_status = "DifferenceStatus",
        .question_id = "QuestionId",
        .question_title = "QuestionTitle",
    };
};
