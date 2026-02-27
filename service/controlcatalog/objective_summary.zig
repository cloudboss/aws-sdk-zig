const AssociatedDomainSummary = @import("associated_domain_summary.zig").AssociatedDomainSummary;

/// A summary of metadata for an objective.
pub const ObjectiveSummary = struct {
    /// The Amazon Resource Name (ARN) that identifies the objective.
    arn: []const u8,

    /// The time when the objective was created.
    create_time: i64,

    /// The description of the objective.
    description: []const u8,

    /// The domain that the objective belongs to.
    domain: AssociatedDomainSummary,

    /// The time when the objective was most recently updated.
    last_update_time: i64,

    /// The name of the objective.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_time = "CreateTime",
        .description = "Description",
        .domain = "Domain",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
    };
};
