/// Structure that contains `payloadVersion` and
/// `targetArn`.
pub const ProvisioningHook = struct {
    /// The payload that was sent to the target function.
    ///
    /// *Note:* Only Lambda functions are currently supported.
    payload_version: ?[]const u8 = null,

    /// The ARN of the target function.
    ///
    /// *Note:* Only Lambda functions are currently supported.
    target_arn: []const u8,

    pub const json_field_names = .{
        .payload_version = "payloadVersion",
        .target_arn = "targetArn",
    };
};
