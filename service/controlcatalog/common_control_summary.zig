const AssociatedDomainSummary = @import("associated_domain_summary.zig").AssociatedDomainSummary;
const AssociatedObjectiveSummary = @import("associated_objective_summary.zig").AssociatedObjectiveSummary;

/// A summary of metadata for a common control.
pub const CommonControlSummary = struct {
    /// The Amazon Resource Name (ARN) that identifies the common control.
    arn: []const u8,

    /// The time when the common control was created.
    create_time: i64,

    /// The description of the common control.
    description: []const u8,

    /// The domain that the common control belongs to.
    domain: AssociatedDomainSummary,

    /// The time when the common control was most recently updated.
    last_update_time: i64,

    /// The name of the common control.
    name: []const u8,

    /// The objective that the common control belongs to.
    objective: AssociatedObjectiveSummary,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_time = "CreateTime",
        .description = "Description",
        .domain = "Domain",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
        .objective = "Objective",
    };
};
