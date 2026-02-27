/// Contains details about a newly created program management account.
pub const CreateProgramManagementAccountDetail = struct {
    /// The Amazon Resource Name (ARN) of the created program management account.
    arn: ?[]const u8,

    /// The unique identifier of the created program management account.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};
