const DNSRecordType = @import("dns_record_type.zig").DNSRecordType;

/// Contains DNS verification details for a target domain, including the DNS
/// record to create for domain ownership verification.
pub const DnsVerification = struct {
    /// The name of the DNS record to create for verification.
    dns_record_name: ?[]const u8 = null,

    /// The type of DNS record to create. Currently, only TXT is supported.
    dns_record_type: ?DNSRecordType = null,

    /// The verification token to include in the DNS record value.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dns_record_name = "dnsRecordName",
        .dns_record_type = "dnsRecordType",
        .token = "token",
    };
};
