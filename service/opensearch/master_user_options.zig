/// Credentials for the master user for a domain.
pub const MasterUserOptions = struct {
    /// Amazon Resource Name (ARN) for the master user. Only specify if
    /// `InternalUserDatabaseEnabled` is `false`.
    master_user_arn: ?[]const u8 = null,

    /// User name for the master user. Only specify if
    /// `InternalUserDatabaseEnabled` is `true`.
    master_user_name: ?[]const u8 = null,

    /// Password for the master user. Only specify if `InternalUserDatabaseEnabled`
    /// is `true`.
    master_user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .master_user_arn = "MasterUserARN",
        .master_user_name = "MasterUserName",
        .master_user_password = "MasterUserPassword",
    };
};
