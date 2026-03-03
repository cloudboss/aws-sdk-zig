/// A DNS record uploaded to your DNS provider.
pub const DnsRecord = struct {
    /// The DNS hostname.- For example, `domain.example.com`.
    hostname: ?[]const u8 = null,

    /// The RFC 1035 record type. Possible values: `CNAME`, `A`, `MX`.
    @"type": ?[]const u8 = null,

    /// The value returned by the DNS for a query to that hostname and record type.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .hostname = "Hostname",
        .@"type" = "Type",
        .value = "Value",
    };
};
