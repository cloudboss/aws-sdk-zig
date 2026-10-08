const DnsVerification = @import("dns_verification.zig").DnsVerification;
const HttpVerification = @import("http_verification.zig").HttpVerification;
const DomainVerificationMethod = @import("domain_verification_method.zig").DomainVerificationMethod;

/// Contains the verification details for a target domain, including the
/// verification method and provider-specific details.
pub const VerificationDetails = struct {
    /// The DNS TXT verification details.
    dns_txt: ?DnsVerification = null,

    /// The HTTP route verification details.
    http_route: ?HttpVerification = null,

    /// The verification method used for the target domain.
    method: ?DomainVerificationMethod = null,

    pub const json_field_names = .{
        .dns_txt = "dnsTxt",
        .http_route = "httpRoute",
        .method = "method",
    };
};
