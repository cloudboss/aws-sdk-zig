/// When there are multiple versions of a blueprint and the latest version has
/// some errors, this attribute indicates the last successful blueprint
/// definition that is available with the service.
pub const LastActiveDefinition = struct {
    /// Specifies a path in Amazon S3 where the blueprint is published by the Glue
    /// developer.
    blueprint_location: ?[]const u8 = null,

    /// Specifies a path in Amazon S3 where the blueprint is copied when you create
    /// or update the blueprint.
    blueprint_service_location: ?[]const u8 = null,

    /// The description of the blueprint.
    description: ?[]const u8 = null,

    /// The date and time the blueprint was last modified.
    last_modified_on: ?i64 = null,

    /// A JSON string specifying the parameters for the blueprint.
    parameter_spec: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_location = "BlueprintLocation",
        .blueprint_service_location = "BlueprintServiceLocation",
        .description = "Description",
        .last_modified_on = "LastModifiedOn",
        .parameter_spec = "ParameterSpec",
    };
};
