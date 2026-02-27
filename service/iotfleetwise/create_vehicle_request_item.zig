const aws = @import("aws");

const VehicleAssociationBehavior = @import("vehicle_association_behavior.zig").VehicleAssociationBehavior;
const StateTemplateAssociation = @import("state_template_association.zig").StateTemplateAssociation;
const Tag = @import("tag.zig").Tag;

/// Information about the vehicle to create.
pub const CreateVehicleRequestItem = struct {
    /// An option to create a new Amazon Web Services IoT thing when creating a
    /// vehicle, or to validate an
    /// existing thing as a vehicle.
    association_behavior: ?VehicleAssociationBehavior,

    /// Static information about a vehicle in a key-value pair. For example:
    /// `"engine
    /// Type"` : `"v6"`
    attributes: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of a decoder manifest associated with the
    /// vehicle to create.
    decoder_manifest_arn: []const u8,

    /// The ARN of the vehicle model (model manifest) to create the vehicle from.
    model_manifest_arn: []const u8,

    /// Associate state templates to track the state of the vehicle. State templates
    /// determine which signal updates the vehicle sends to the cloud.
    state_templates: ?[]const StateTemplateAssociation,

    /// Metadata which can be used to manage the vehicle.
    tags: ?[]const Tag,

    /// The unique ID of the vehicle to create.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .association_behavior = "associationBehavior",
        .attributes = "attributes",
        .decoder_manifest_arn = "decoderManifestArn",
        .model_manifest_arn = "modelManifestArn",
        .state_templates = "stateTemplates",
        .tags = "tags",
        .vehicle_name = "vehicleName",
    };
};
