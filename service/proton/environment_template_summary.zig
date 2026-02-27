const Provisioning = @import("provisioning.zig").Provisioning;

/// The environment template data.
pub const EnvironmentTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the environment template.
    arn: []const u8,

    /// The time when the environment template was created.
    created_at: i64,

    /// A description of the environment template.
    description: ?[]const u8,

    /// The name of the environment template as displayed in the developer
    /// interface.
    display_name: ?[]const u8,

    /// The time when the environment template was last modified.
    last_modified_at: i64,

    /// The name of the environment template.
    name: []const u8,

    /// When included, indicates that the environment template is for customer
    /// provisioned and managed infrastructure.
    provisioning: ?Provisioning,

    /// The recommended version of the environment template.
    recommended_version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .last_modified_at = "lastModifiedAt",
        .name = "name",
        .provisioning = "provisioning",
        .recommended_version = "recommendedVersion",
    };
};
