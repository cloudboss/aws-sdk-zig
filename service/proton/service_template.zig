const Provisioning = @import("provisioning.zig").Provisioning;

/// Detailed data of an Proton service template resource.
pub const ServiceTemplate = struct {
    /// The Amazon Resource Name (ARN) of the service template.
    arn: []const u8,

    /// The time when the service template was created.
    created_at: i64,

    /// A description of the service template.
    description: ?[]const u8 = null,

    /// The service template name as displayed in the developer interface.
    display_name: ?[]const u8 = null,

    /// The customer provided service template encryption key that's used to encrypt
    /// data.
    encryption_key: ?[]const u8 = null,

    /// The time when the service template was last modified.
    last_modified_at: i64,

    /// The name of the service template.
    name: []const u8,

    /// If `pipelineProvisioning` is `true`, a service pipeline is included
    /// in the service template. Otherwise, a service pipeline *isn't* included in
    /// the service template.
    pipeline_provisioning: ?Provisioning = null,

    /// The recommended version of the service template.
    recommended_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .encryption_key = "encryptionKey",
        .last_modified_at = "lastModifiedAt",
        .name = "name",
        .pipeline_provisioning = "pipelineProvisioning",
        .recommended_version = "recommendedVersion",
    };
};
