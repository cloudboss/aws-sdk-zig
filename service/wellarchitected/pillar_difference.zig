const DifferenceStatus = @import("difference_status.zig").DifferenceStatus;
const QuestionDifference = @import("question_difference.zig").QuestionDifference;

/// A pillar difference return object.
pub const PillarDifference = struct {
    /// Indicates the type of change to the pillar.
    difference_status: ?DifferenceStatus,

    pillar_id: ?[]const u8,

    pillar_name: ?[]const u8,

    /// List of question differences.
    question_differences: ?[]const QuestionDifference,

    pub const json_field_names = .{
        .difference_status = "DifferenceStatus",
        .pillar_id = "PillarId",
        .pillar_name = "PillarName",
        .question_differences = "QuestionDifferences",
    };
};
