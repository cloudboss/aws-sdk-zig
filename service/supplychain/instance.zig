const InstanceState = @import("instance_state.zig").InstanceState;

/// The details of the instance.
pub const Instance = struct {
    /// The Amazon Web Services account ID that owns the instance.
    aws_account_id: []const u8,

    /// The instance creation timestamp.
    created_time: ?i64,

    /// The Amazon Web Services Supply Chain instance error message. If the instance
    /// results in an unhealthy state, customers need to check the error message,
    /// delete the current instance, and recreate a new one based on the mitigation
    /// from the error message.
    error_message: ?[]const u8,

    /// The Amazon Web Services Supply Chain instance description.
    instance_description: ?[]const u8,

    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The Amazon Web Services Supply Chain instance name.
    instance_name: ?[]const u8,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// optionally provided for encryption. If you did not provide anything here,
    /// AWS Supply Chain uses the Amazon Web Services owned KMS key and nothing is
    /// returned.
    kms_key_arn: ?[]const u8,

    /// The instance last modified timestamp.
    last_modified_time: ?i64,

    /// The state of the instance.
    state: InstanceState,

    /// The version number of the instance.
    version_number: ?f64,

    /// The WebApp DNS domain name of the instance.
    web_app_dns_domain: ?[]const u8,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .created_time = "createdTime",
        .error_message = "errorMessage",
        .instance_description = "instanceDescription",
        .instance_id = "instanceId",
        .instance_name = "instanceName",
        .kms_key_arn = "kmsKeyArn",
        .last_modified_time = "lastModifiedTime",
        .state = "state",
        .version_number = "versionNumber",
        .web_app_dns_domain = "webAppDnsDomain",
    };
};
