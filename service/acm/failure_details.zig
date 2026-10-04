const AcmeDomainValidationFailureReason = @import("acme_domain_validation_failure_reason.zig").AcmeDomainValidationFailureReason;

/// Contains details about a failure.
pub const FailureDetails = struct {
    /// A message describing the failure.
    message: ?[]const u8 = null,

    /// The reason for the failure.
    reason: ?AcmeDomainValidationFailureReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};
