/// Provides information about the role that is assigned to the user.
pub const RoleInfo = struct {
    /// The identifier of the AWS account assigned to the user.
    account_id: ?[]const u8,

    /// The friendly name of the role that is assigned to the user.
    role_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .role_name = "roleName",
    };
};
