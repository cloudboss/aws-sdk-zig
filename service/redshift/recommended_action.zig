const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;

/// The recommended action from the Amazon Redshift Advisor recommendation.
pub const RecommendedAction = struct {
    /// The command to run.
    command: ?[]const u8,

    /// The database name to perform the action on. Only applicable if the type of
    /// command is SQL.
    database: ?[]const u8,

    /// The specific instruction about the command.
    text: ?[]const u8,

    /// The type of command.
    type: ?RecommendedActionType,
};
