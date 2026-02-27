const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const CreateDomainResponse = struct {
    /// The Amazon Resource Name (ARN) for the Cases domain.
    domain_arn: []const u8,

    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// The status of the domain.
    domain_status: DomainStatus,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
        .domain_id = "domainId",
        .domain_status = "domainStatus",
    };
};
