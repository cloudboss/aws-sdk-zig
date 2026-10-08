const aws = @import("aws");

/// Represents a system in Resilience Hub. A system is a logical grouping of
/// services.
pub const System = struct {
    /// The timestamp when the system was created.
    created_at: ?i64 = null,

    description: ?[]const u8 = null,

    kms_key_id: ?[]const u8 = null,

    name: []const u8,

    /// The AWS Organizations identifier for the system.
    organization_id: ?[]const u8 = null,

    /// The organizational unit (OU) identifier for the system.
    ou_id: ?[]const u8 = null,

    /// Indicates whether cross-account sharing is enabled.
    sharing_enabled: ?bool = null,

    system_arn: []const u8,

    system_id: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the system was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .organization_id = "organizationId",
        .ou_id = "ouId",
        .sharing_enabled = "sharingEnabled",
        .system_arn = "systemArn",
        .system_id = "systemId",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
