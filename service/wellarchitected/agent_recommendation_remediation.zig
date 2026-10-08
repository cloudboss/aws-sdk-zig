const ResourceLink = @import("resource_link.zig").ResourceLink;
const RemediationStep = @import("remediation_step.zig").RemediationStep;
const RemediationType = @import("remediation_type.zig").RemediationType;

/// The core fields for a remediation.
pub const AgentRecommendationRemediation = struct {
    /// The timestamp when the remediation was created.
    created_at: i64,

    /// The identifier of the user or system that created this remediation.
    created_by: []const u8,

    /// The timestamp when the remediation was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this remediation.
    last_modified_by: ?[]const u8 = null,

    /// The ARN of the recommendation that this remediation belongs to.
    recommendation_arn: []const u8,

    /// External references associated with the steps.
    resource_links: ?[]const ResourceLink = null,

    /// The procedural steps to perform the remediation.
    steps: []const RemediationStep,

    /// The remediation method.
    type: RemediationType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .recommendation_arn = "recommendationArn",
        .resource_links = "resourceLinks",
        .steps = "steps",
        .type = "type",
    };
};
