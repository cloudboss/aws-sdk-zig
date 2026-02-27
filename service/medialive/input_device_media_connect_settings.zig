/// Information about the MediaConnect flow attached to the device.
pub const InputDeviceMediaConnectSettings = struct {
    /// The ARN of the MediaConnect flow.
    flow_arn: ?[]const u8,

    /// The ARN for the role that MediaLive assumes to access the attached flow and
    /// secret.
    role_arn: ?[]const u8,

    /// The ARN of the secret used to encrypt the stream.
    secret_arn: ?[]const u8,

    /// The name of the MediaConnect flow source.
    source_name: ?[]const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .role_arn = "RoleArn",
        .secret_arn = "SecretArn",
        .source_name = "SourceName",
    };
};
