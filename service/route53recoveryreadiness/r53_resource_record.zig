/// The Route 53 resource that a DNS target resource record points to.
pub const R53ResourceRecord = struct {
    /// The DNS target domain name.
    domain_name: ?[]const u8 = null,

    /// The Route 53 Resource Record Set ID.
    record_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .record_set_id = "RecordSetId",
    };
};
