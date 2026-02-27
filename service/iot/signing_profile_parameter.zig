/// Describes the code-signing profile.
pub const SigningProfileParameter = struct {
    /// Certificate ARN.
    certificate_arn: ?[]const u8,

    /// The location of the code-signing certificate on your device.
    certificate_path_on_device: ?[]const u8,

    /// The hardware platform of your device.
    platform: ?[]const u8,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_path_on_device = "certificatePathOnDevice",
        .platform = "platform",
    };
};
