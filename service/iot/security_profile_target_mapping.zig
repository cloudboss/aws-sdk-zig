const SecurityProfileIdentifier = @import("security_profile_identifier.zig").SecurityProfileIdentifier;
const SecurityProfileTarget = @import("security_profile_target.zig").SecurityProfileTarget;

/// Information about a security profile and the target associated with it.
pub const SecurityProfileTargetMapping = struct {
    /// Information that identifies the security profile.
    security_profile_identifier: ?SecurityProfileIdentifier,

    /// Information about the target (thing group) associated with the security
    /// profile.
    target: ?SecurityProfileTarget,

    pub const json_field_names = .{
        .security_profile_identifier = "securityProfileIdentifier",
        .target = "target",
    };
};
