pub const CreateMemberResponse = struct {
    /// The Amazon Resource Name (ARN) of the account that was associated with the
    /// administrator account.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
