/// Parameters required to attach a MediaConnect flow to the device.
pub const InputDeviceMediaConnectConfigurableSettings = struct {
    /// The ARN of the MediaConnect flow to attach this device to.
    flow_arn: ?[]const u8,

    /// The ARN for the role that MediaLive assumes to access the attached flow and
    /// secret. For more information about how to create this role, see the
    /// MediaLive user guide.
    role_arn: ?[]const u8,

    /// The ARN for the secret that holds the encryption key to encrypt the content
    /// output by the device.
    secret_arn: ?[]const u8,

    /// The name of the MediaConnect Flow source to stream to.
    source_name: ?[]const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .role_arn = "RoleArn",
        .secret_arn = "SecretArn",
        .source_name = "SourceName",
    };
};
