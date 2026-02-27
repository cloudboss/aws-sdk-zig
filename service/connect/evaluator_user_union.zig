/// Represents the entity that performed the action on the evaluation.
pub const EvaluatorUserUnion = union(enum) {
    /// Represents the Amazon Connect ARN of the user.
    connect_user_arn: ?[]const u8,

    pub const json_field_names = .{
        .connect_user_arn = "ConnectUserArn",
    };
};
