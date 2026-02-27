/// Object for the summarized details of the domain.
pub const DomainSummary = struct {
    /// The Amazon Resource Name (ARN) of the domain.
    domain_arn: []const u8,

    /// The unique identifier of the domain.
    domain_id: []const u8,

    /// The name of the domain.
    name: []const u8,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
        .domain_id = "domainId",
        .name = "name",
    };
};
