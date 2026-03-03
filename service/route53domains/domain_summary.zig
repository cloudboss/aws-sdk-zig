/// Summary information about one domain.
pub const DomainSummary = struct {
    /// Indicates whether the domain is automatically renewed upon expiration.
    auto_renew: ?bool = null,

    /// The name of the domain that the summary information applies to.
    domain_name: ?[]const u8 = null,

    /// Expiration date of the domain in Unix time format and Coordinated Universal
    /// Time
    /// (UTC).
    expiry: ?i64 = null,

    /// Indicates whether a domain is locked from unauthorized transfer to another
    /// party.
    transfer_lock: ?bool = null,

    pub const json_field_names = .{
        .auto_renew = "AutoRenew",
        .domain_name = "DomainName",
        .expiry = "Expiry",
        .transfer_lock = "TransferLock",
    };
};
