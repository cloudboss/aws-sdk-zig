/// The target of a message, a sender, a user, or a bot. Only the target and the
/// sender can view targeted messages.
/// Only users who can see targeted messages can take actions on them. However,
/// administrators can delete targeted messages that they can’t see.
pub const Target = struct {
    /// The ARN of the target channel member.
    member_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .member_arn = "MemberArn",
    };
};
