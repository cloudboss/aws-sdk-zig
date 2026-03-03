const ImageAssociatedResourceType = @import("image_associated_resource_type.zig").ImageAssociatedResourceType;
const AssociationState = @import("association_state.zig").AssociationState;
const AssociationStateReason = @import("association_state_reason.zig").AssociationStateReason;

/// Describes the association between an application and an image resource.
pub const ImageResourceAssociation = struct {
    /// The identifier of the associated resource.
    associated_resource_id: ?[]const u8 = null,

    /// The resource type of the associated resources.
    associated_resource_type: ?ImageAssociatedResourceType = null,

    /// The time the association is created.
    created: ?i64 = null,

    /// The identifier of the image.
    image_id: ?[]const u8 = null,

    /// The time the association status was last updated.
    last_updated_time: ?i64 = null,

    /// The status of the image resource association.
    state: ?AssociationState = null,

    /// The reason the association deployment failed.
    state_reason: ?AssociationStateReason = null,

    pub const json_field_names = .{
        .associated_resource_id = "AssociatedResourceId",
        .associated_resource_type = "AssociatedResourceType",
        .created = "Created",
        .image_id = "ImageId",
        .last_updated_time = "LastUpdatedTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};
