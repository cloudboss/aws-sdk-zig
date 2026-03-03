const WorkSpaceAssociatedResourceType = @import("work_space_associated_resource_type.zig").WorkSpaceAssociatedResourceType;
const AssociationState = @import("association_state.zig").AssociationState;
const AssociationStateReason = @import("association_state_reason.zig").AssociationStateReason;

/// Describes the association between an application and a WorkSpace resource.
pub const WorkspaceResourceAssociation = struct {
    /// The identifier of the associated resource.
    associated_resource_id: ?[]const u8 = null,

    /// The resource types of the associated resource.
    associated_resource_type: ?WorkSpaceAssociatedResourceType = null,

    /// The time the association is created.
    created: ?i64 = null,

    /// The time the association status was last updated.
    last_updated_time: ?i64 = null,

    /// The status of the WorkSpace resource association.
    state: ?AssociationState = null,

    /// The reason the association deployment failed.
    state_reason: ?AssociationStateReason = null,

    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_resource_id = "AssociatedResourceId",
        .associated_resource_type = "AssociatedResourceType",
        .created = "Created",
        .last_updated_time = "LastUpdatedTime",
        .state = "State",
        .state_reason = "StateReason",
        .workspace_id = "WorkspaceId",
    };
};
