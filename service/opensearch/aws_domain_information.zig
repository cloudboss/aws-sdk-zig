/// Information about an Amazon OpenSearch Service domain.
pub const AWSDomainInformation = struct {
    /// Name of the domain.
    domain_name: []const u8,

    /// The Amazon Web Services account ID of the domain owner.
    owner_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the domain is located.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .owner_id = "OwnerId",
        .region = "Region",
    };
};
