/// Information of a test device. A thing ARN, certificate ARN
/// or device role ARN is required.
pub const DeviceUnderTest = struct {
    /// Lists device's certificate ARN.
    certificate_arn: ?[]const u8 = null,

    /// Lists device's role ARN.
    device_role_arn: ?[]const u8 = null,

    /// Lists device's thing ARN.
    thing_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .device_role_arn = "deviceRoleArn",
        .thing_arn = "thingArn",
    };
};
