/// Represents the entity that performed the action.
pub const UserUnion = union(enum) {
    /// Any provided entity.
    custom_entity: ?[]const u8,
    /// Represents the Amazon Connect ARN of the user.
    user_arn: ?[]const u8,

    pub const json_field_names = .{
        .custom_entity = "customEntity",
        .user_arn = "userArn",
    };
};
