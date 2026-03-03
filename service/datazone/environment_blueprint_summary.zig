const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;

/// The details of an environment blueprint summary.
pub const EnvironmentBlueprintSummary = struct {
    /// The timestamp of when an environment blueprint was created.
    created_at: ?i64 = null,

    /// The description of a blueprint.
    description: ?[]const u8 = null,

    /// The identifier of the blueprint.
    id: []const u8,

    /// The name of the blueprint.
    name: []const u8,

    /// The provider of the blueprint.
    provider: []const u8,

    /// The provisioning properties of the blueprint.
    provisioning_properties: ProvisioningProperties,

    /// The timestamp of when the blueprint was enabled.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .name = "name",
        .provider = "provider",
        .provisioning_properties = "provisioningProperties",
        .updated_at = "updatedAt",
    };
};
