const Provisioning = @import("provisioning.zig").Provisioning;

/// Summary data of an Proton service template resource.
pub const ServiceTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the service template.
    arn: []const u8,

    /// The time when the service template was created.
    created_at: i64,

    /// A description of the service template.
    description: ?[]const u8,

    /// The service template name as displayed in the developer interface.
    display_name: ?[]const u8,

    /// The time when the service template was last modified.
    last_modified_at: i64,

    /// The name of the service template.
    name: []const u8,

    /// If `pipelineProvisioning` is `true`, a service pipeline is included
    /// in the service template, otherwise a service pipeline *isn't* included in
    /// the service template.
    pipeline_provisioning: ?Provisioning,

    /// The recommended version of the service template.
    recommended_version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .last_modified_at = "lastModifiedAt",
        .name = "name",
        .pipeline_provisioning = "pipelineProvisioning",
        .recommended_version = "recommendedVersion",
    };
};
