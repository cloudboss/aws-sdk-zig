const aws = @import("aws");

const GranularAccessControlConfiguration = @import("granular_access_control_configuration.zig").GranularAccessControlConfiguration;

/// Contains information about a security profile.
pub const SecurityProfile = struct {
    /// The identifier of the hierarchy group that a security profile uses to
    /// restrict access to resources in Amazon Connect.
    allowed_access_control_hierarchy_group_id: ?[]const u8,

    /// The list of tags that a security profile uses to restrict access to
    /// resources in Amazon Connect.
    allowed_access_control_tags: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) for the security profile.
    arn: ?[]const u8,

    /// The description of the security profile.
    description: ?[]const u8,

    /// The granular access control configuration for the security profile,
    /// including data table permissions.
    granular_access_control_configuration: ?GranularAccessControlConfiguration,

    /// The list of resources that a security profile applies hierarchy restrictions
    /// to in Amazon Connect. Following
    /// are acceptable ResourceNames: `User`.
    hierarchy_restricted_resources: ?[]const []const u8,

    /// The identifier for the security profile.
    id: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The organization resource identifier for the security profile.
    organization_resource_id: ?[]const u8,

    /// The name for the security profile.
    security_profile_name: ?[]const u8,

    /// The list of resources that a security profile applies tag restrictions to in
    /// Amazon Connect.
    tag_restricted_resources: ?[]const []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .allowed_access_control_hierarchy_group_id = "AllowedAccessControlHierarchyGroupId",
        .allowed_access_control_tags = "AllowedAccessControlTags",
        .arn = "Arn",
        .description = "Description",
        .granular_access_control_configuration = "GranularAccessControlConfiguration",
        .hierarchy_restricted_resources = "HierarchyRestrictedResources",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .organization_resource_id = "OrganizationResourceId",
        .security_profile_name = "SecurityProfileName",
        .tag_restricted_resources = "TagRestrictedResources",
        .tags = "Tags",
    };
};
