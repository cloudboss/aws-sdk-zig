const RecordType = @import("record_type.zig").RecordType;

/// Contains a DNS record value that you can use to validate ownership or
/// control of a domain. This is used by the DescribeCertificate action.
pub const ResourceRecord = struct {
    /// The name of the DNS record to create in your domain. This is supplied by
    /// ACM.
    name: []const u8,

    /// The type of DNS record. Currently this can be `CNAME`.
    type: RecordType,

    /// The value of the CNAME record to add to your DNS database. This is supplied
    /// by ACM.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
        .value = "Value",
    };
};
