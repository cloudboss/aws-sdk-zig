const aws = @import("aws");

pub const RegistrySummary = struct {
    /// The ARN of the registry.
    registry_arn: ?[]const u8,

    /// The name of the registry.
    registry_name: ?[]const u8,

    /// Tags associated with the registry.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .tags = "Tags",
    };
};
