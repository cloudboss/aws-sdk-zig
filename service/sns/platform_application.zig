const aws = @import("aws");

/// Platform application object.
pub const PlatformApplication = struct {
    /// Attributes for platform application object.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// PlatformApplicationArn for platform application object.
    platform_application_arn: ?[]const u8 = null,
};
