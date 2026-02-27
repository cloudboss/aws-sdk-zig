pub const DescribeDomainRequest = struct {
    /// The identifier of the domain that you are describing.
    domain_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
    };
};
