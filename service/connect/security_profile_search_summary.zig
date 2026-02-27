const aws = @import("aws");

/// Information about the returned security profiles.
pub const SecurityProfileSearchSummary = struct {
    /// The Amazon Resource Name (ARN) of the security profile.
    arn: ?[]const u8,

    /// The description of the security profile.
    description: ?[]const u8,

    /// The identifier of the security profile.
    id: ?[]const u8,

    /// The organization resource identifier.
    organization_resource_id: ?[]const u8,

    /// The name of the security profile.
    security_profile_name: ?[]const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .organization_resource_id = "OrganizationResourceId",
        .security_profile_name = "SecurityProfileName",
        .tags = "Tags",
    };
};
