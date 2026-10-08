const DomainStatus = @import("domain_status.zig").DomainStatus;

/// Summary information about a Domain.
pub const DomainSummary = struct {
    arn: []const u8,

    /// The timestamp when the Domain was created.
    created_at: i64,

    /// The unique identifier of the Domain.
    domain_id: []const u8,

    name: []const u8,

    status: DomainStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_id = "domainId",
        .name = "name",
        .status = "status",
    };
};
