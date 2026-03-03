/// Contains details about an updated program management account.
pub const UpdateProgramManagementAccountDetail = struct {
    /// The Amazon Resource Name (ARN) of the updated program management account.
    arn: ?[]const u8 = null,

    /// The updated display name of the program management account.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the updated program management account.
    id: ?[]const u8 = null,

    /// The new revision number of the program management account.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .display_name = "displayName",
        .id = "id",
        .revision = "revision",
    };
};
