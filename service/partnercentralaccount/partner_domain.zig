/// Represents a verified domain associated with a partner account.
pub const PartnerDomain = struct {
    /// The domain name that has been verified for the partner account.
    domain_name: []const u8,

    /// The timestamp when the domain was registered and verified for the partner
    /// account.
    registered_at: i64,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .registered_at = "RegisteredAt",
    };
};
