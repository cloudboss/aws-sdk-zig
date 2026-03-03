const OriginAccessControlConfig = @import("origin_access_control_config.zig").OriginAccessControlConfig;

/// A CloudFront origin access control, including its unique identifier.
pub const OriginAccessControl = struct {
    /// The unique identifier of the origin access control.
    id: []const u8,

    /// The origin access control.
    origin_access_control_config: ?OriginAccessControlConfig = null,
};
