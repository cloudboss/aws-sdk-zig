/// Information about a core.
pub const Core = struct {
    /// The ARN of the certificate associated with the core.
    certificate_arn: []const u8,

    /// A descriptive or arbitrary ID for the core. This value must be unique within
    /// the core definition version. Max length is 128 characters with pattern
    /// ''[a-zA-Z0-9:_-]+''.
    id: []const u8,

    /// If true, the core's local shadow is automatically synced with the cloud.
    sync_shadow: ?bool = null,

    /// The ARN of the thing which is the core.
    thing_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .id = "Id",
        .sync_shadow = "SyncShadow",
        .thing_arn = "ThingArn",
    };
};
