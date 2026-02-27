const SupportedPlatform = @import("supported_platform.zig").SupportedPlatform;

/// Describes an availability zone.
pub const AvailabilityZone = struct {
    /// The name of the availability zone.
    name: ?[]const u8,

    supported_platforms: ?[]const SupportedPlatform,
};
