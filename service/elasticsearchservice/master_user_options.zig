/// Credentials for the master user: username and password, ARN, or both.
pub const MasterUserOptions = struct {
    /// ARN for the master user (if IAM is enabled).
    master_user_arn: ?[]const u8 = null,

    /// The master user's username, which is stored in the Amazon Elasticsearch
    /// Service domain's internal database.
    master_user_name: ?[]const u8 = null,

    /// The master user's password, which is stored in the Amazon Elasticsearch
    /// Service domain's internal database.
    master_user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .master_user_arn = "MasterUserARN",
        .master_user_name = "MasterUserName",
        .master_user_password = "MasterUserPassword",
    };
};
