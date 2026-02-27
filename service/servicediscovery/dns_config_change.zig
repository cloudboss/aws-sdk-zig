const DnsRecord = @import("dns_record.zig").DnsRecord;

/// A complex type that contains information about changes to the Route 53 DNS
/// records that
/// Cloud Map creates when you register an instance.
pub const DnsConfigChange = struct {
    /// An array that contains one `DnsRecord` object for each Route 53 record that
    /// you want
    /// Cloud Map to create when you register an instance.
    dns_records: []const DnsRecord,

    pub const json_field_names = .{
        .dns_records = "DnsRecords",
    };
};
