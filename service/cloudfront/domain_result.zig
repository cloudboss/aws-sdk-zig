const DomainStatus = @import("domain_status.zig").DomainStatus;

/// The details about the domain result.
pub const DomainResult = struct {
    /// The specified domain.
    domain: []const u8,

    /// Whether the domain is active or inactive.
    status: ?DomainStatus,
};
