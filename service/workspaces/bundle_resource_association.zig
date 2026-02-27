const BundleAssociatedResourceType = @import("bundle_associated_resource_type.zig").BundleAssociatedResourceType;
const AssociationState = @import("association_state.zig").AssociationState;
const AssociationStateReason = @import("association_state_reason.zig").AssociationStateReason;

/// Describes the association between an application and a bundle resource.
pub const BundleResourceAssociation = struct {
    /// The identifier of the associated resource.
    associated_resource_id: ?[]const u8,

    /// The resource type of the associated resources.
    associated_resource_type: ?BundleAssociatedResourceType,

    /// The identifier of the bundle.
    bundle_id: ?[]const u8,

    /// The time the association is created.
    created: ?i64,

    /// The time the association status was last updated.
    last_updated_time: ?i64,

    /// The status of the bundle resource association.
    state: ?AssociationState,

    /// The reason the association deployment failed.
    state_reason: ?AssociationStateReason,

    pub const json_field_names = .{
        .associated_resource_id = "AssociatedResourceId",
        .associated_resource_type = "AssociatedResourceType",
        .bundle_id = "BundleId",
        .created = "Created",
        .last_updated_time = "LastUpdatedTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};
