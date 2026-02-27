/// Provided if `ActionType` is `DNS_REQUEST`. It provides details
/// about the DNS request that was detected.
pub const DnsRequestAction = struct {
    /// Indicates whether the DNS request was blocked.
    blocked: ?bool,

    /// The DNS domain that is associated with the DNS request.
    ///
    /// Length Constraints: 128.
    domain: ?[]const u8,

    /// The protocol that was used for the DNS request.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 64.
    protocol: ?[]const u8,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .domain = "Domain",
        .protocol = "Protocol",
    };
};
