const CapabilityFailureReason = @import("capability_failure_reason.zig").CapabilityFailureReason;

/// Information about a capability failure.
pub const CapabilityFailure = struct {
    /// Additional details about the capability failure.
    details: ?[]const u8 = null,

    /// The reason for the capability failure. Possible values:
    /// `KMS_KEY_INSUFFICIENT_PERMISSION`.
    reason: ?CapabilityFailureReason = null,

    pub const json_field_names = .{
        .details = "details",
        .reason = "reason",
    };
};
