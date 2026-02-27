const LastActiveDefinition = @import("last_active_definition.zig").LastActiveDefinition;
const BlueprintStatus = @import("blueprint_status.zig").BlueprintStatus;

/// The details of a blueprint.
pub const Blueprint = struct {
    /// Specifies the path in Amazon S3 where the blueprint is published.
    blueprint_location: ?[]const u8,

    /// Specifies a path in Amazon S3 where the blueprint is copied when you call
    /// `CreateBlueprint/UpdateBlueprint` to register the blueprint in Glue.
    blueprint_service_location: ?[]const u8,

    /// The date and time the blueprint was registered.
    created_on: ?i64,

    /// The description of the blueprint.
    description: ?[]const u8,

    /// An error message.
    error_message: ?[]const u8,

    /// When there are multiple versions of a blueprint and the latest version has
    /// some errors, this attribute indicates the last successful blueprint
    /// definition that is available with the service.
    last_active_definition: ?LastActiveDefinition,

    /// The date and time the blueprint was last modified.
    last_modified_on: ?i64,

    /// The name of the blueprint.
    name: ?[]const u8,

    /// A JSON string that indicates the list of parameter specifications for the
    /// blueprint.
    parameter_spec: ?[]const u8,

    /// The status of the blueprint registration.
    ///
    /// * Creating — The blueprint registration is in progress.
    ///
    /// * Active — The blueprint has been successfully registered.
    ///
    /// * Updating — An update to the blueprint registration is in progress.
    ///
    /// * Failed — The blueprint registration failed.
    status: ?BlueprintStatus,

    pub const json_field_names = .{
        .blueprint_location = "BlueprintLocation",
        .blueprint_service_location = "BlueprintServiceLocation",
        .created_on = "CreatedOn",
        .description = "Description",
        .error_message = "ErrorMessage",
        .last_active_definition = "LastActiveDefinition",
        .last_modified_on = "LastModifiedOn",
        .name = "Name",
        .parameter_spec = "ParameterSpec",
        .status = "Status",
    };
};
