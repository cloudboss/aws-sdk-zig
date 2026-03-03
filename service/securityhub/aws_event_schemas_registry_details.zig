/// A schema defines the structure of events that are sent to Amazon
/// EventBridge. Schema registries are containers for
/// schemas. They collect and organize schemas so that your schemas are in
/// logical groups.
pub const AwsEventSchemasRegistryDetails = struct {
    /// A description of the registry to be created.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the schema registry.
    registry_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
    };
};
