/// Information about a device.
pub const Device = struct {
    /// The ARN of the certificate associated with the device.
    certificate_arn: []const u8,

    /// A descriptive or arbitrary ID for the device. This value must be unique
    /// within the device definition version. Max length is 128 characters with
    /// pattern ''[a-zA-Z0-9:_-]+''.
    id: []const u8,

    /// If true, the device's local shadow will be automatically synced with the
    /// cloud.
    sync_shadow: ?bool,

    /// The thing ARN of the device.
    thing_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .id = "Id",
        .sync_shadow = "SyncShadow",
        .thing_arn = "ThingArn",
    };
};
