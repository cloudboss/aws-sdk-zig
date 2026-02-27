/// Describes the domain name system (DNS) records to add to your domain's DNS
/// to validate it
/// for an Amazon Lightsail certificate.
pub const ResourceRecord = struct {
    /// The name of the record.
    name: ?[]const u8,

    /// The DNS record type.
    type: ?[]const u8,

    /// The value for the DNS record.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
        .value = "value",
    };
};
