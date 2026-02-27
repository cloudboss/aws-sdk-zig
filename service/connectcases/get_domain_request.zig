pub const GetDomainRequest = struct {
    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
    };
};
