const VerificationDetails = @import("verification_details.zig").VerificationDetails;
const TargetDomainStatus = @import("target_domain_status.zig").TargetDomainStatus;

/// Represents a target domain registered for penetration testing. A target
/// domain must be verified through DNS TXT or HTTP route verification before it
/// can be used in pentests.
pub const TargetDomain = struct {
    /// The date and time the target domain was created, in UTC format.
    created_at: ?i64 = null,

    /// The domain name of the target domain.
    domain_name: []const u8,

    /// The unique identifier of the target domain.
    target_domain_id: []const u8,

    /// The verification details for the target domain.
    verification_details: ?VerificationDetails = null,

    /// The current verification status of the target domain.
    verification_status: ?TargetDomainStatus = null,

    /// The reason for the current target domain verification status.
    verification_status_reason: ?[]const u8 = null,

    /// The date and time the target domain was verified, in UTC format.
    verified_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .domain_name = "domainName",
        .target_domain_id = "targetDomainId",
        .verification_details = "verificationDetails",
        .verification_status = "verificationStatus",
        .verification_status_reason = "verificationStatusReason",
        .verified_at = "verifiedAt",
    };
};
