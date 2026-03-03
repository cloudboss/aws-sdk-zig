const ApplicationAssociatedResourceType = @import("application_associated_resource_type.zig").ApplicationAssociatedResourceType;
const AssociationState = @import("association_state.zig").AssociationState;
const AssociationStateReason = @import("association_state_reason.zig").AssociationStateReason;

/// Describes the association between an application and an application
/// resource.
pub const ApplicationResourceAssociation = struct {
    /// The identifier of the application.
    application_id: ?[]const u8 = null,

    /// The identifier of the associated resource.
    associated_resource_id: ?[]const u8 = null,

    /// The resource type of the associated resource.
    associated_resource_type: ?ApplicationAssociatedResourceType = null,

    /// The time the association was created.
    created: ?i64 = null,

    /// The time the association status was last updated.
    last_updated_time: ?i64 = null,

    /// The status of the application resource association.
    state: ?AssociationState = null,

    /// The reason the association deployment failed.
    state_reason: ?AssociationStateReason = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .associated_resource_id = "AssociatedResourceId",
        .associated_resource_type = "AssociatedResourceType",
        .created = "Created",
        .last_updated_time = "LastUpdatedTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};
