/// An object that consists of a member Amazon Resource Name (ARN) and a member
/// ID.
pub const MemberIdArnPair = struct {
    /// The Amazon Resource Name (ARN) of the member.
    member_arn: ?[]const u8,

    /// The ID of the member.
    member_id: ?[]const u8,

    pub const json_field_names = .{
        .member_arn = "MemberArn",
        .member_id = "MemberId",
    };
};
