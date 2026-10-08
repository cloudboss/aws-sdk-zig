const TargetDomainStatus = @import("target_domain_status.zig").TargetDomainStatus;

/// Contains summary information about a target domain.
pub const TargetDomainSummary = struct {
    /// The domain name of the target domain.
    domain_name: []const u8,

    /// The unique identifier of the target domain.
    target_domain_id: []const u8,

    /// The current verification status of the target domain.
    verification_status: ?TargetDomainStatus = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .target_domain_id = "targetDomainId",
        .verification_status = "verificationStatus",
    };
};
