const aws = @import("aws");

const UpdateMode = @import("update_mode.zig").UpdateMode;
const StateTemplateAssociation = @import("state_template_association.zig").StateTemplateAssociation;

/// Information about the vehicle to update.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const UpdateVehicleRequestItem = struct {
    /// Static information about a vehicle in a key-value pair. For example:
    ///
    /// `"engineType"` : `"1.3 L R2"`
    attributes: ?[]const aws.map.StringMapEntry,

    /// The method the specified attributes will update the existing attributes on
    /// the
    /// vehicle. Use`Overwite` to replace the vehicle attributes with the specified
    /// attributes. Or use `Merge` to combine all attributes.
    ///
    /// This is required if attributes are present in the input.
    attribute_update_mode: ?UpdateMode,

    /// The ARN of the signal decoder manifest associated with the vehicle to
    /// update.
    decoder_manifest_arn: ?[]const u8,

    /// The ARN of the vehicle model (model manifest) associated with the vehicle to
    /// update.
    model_manifest_arn: ?[]const u8,

    /// Associate additional state templates to track the state of the vehicle.
    /// State templates determine which signal updates the vehicle sends to the
    /// cloud.
    state_templates_to_add: ?[]const StateTemplateAssociation,

    /// Remove existing state template associations from the vehicle.
    state_templates_to_remove: ?[]const []const u8,

    /// Change the `stateTemplateUpdateStrategy` of state templates already
    /// associated with the vehicle.
    state_templates_to_update: ?[]const StateTemplateAssociation,

    /// The unique ID of the vehicle to update.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .attribute_update_mode = "attributeUpdateMode",
        .decoder_manifest_arn = "decoderManifestArn",
        .model_manifest_arn = "modelManifestArn",
        .state_templates_to_add = "stateTemplatesToAdd",
        .state_templates_to_remove = "stateTemplatesToRemove",
        .state_templates_to_update = "stateTemplatesToUpdate",
        .vehicle_name = "vehicleName",
    };
};
