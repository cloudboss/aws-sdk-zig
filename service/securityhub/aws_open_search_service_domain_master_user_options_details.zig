/// Specifies information about the master user of the domain.
pub const AwsOpenSearchServiceDomainMasterUserOptionsDetails = struct {
    /// The Amazon Resource Name (ARN) for the master user.
    master_user_arn: ?[]const u8 = null,

    /// The username for the master user.
    master_user_name: ?[]const u8 = null,

    /// The password for the master user.
    master_user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .master_user_arn = "MasterUserArn",
        .master_user_name = "MasterUserName",
        .master_user_password = "MasterUserPassword",
    };
};
