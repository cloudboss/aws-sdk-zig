const ManagedThingAssociationStatus = @import("managed_thing_association_status.zig").ManagedThingAssociationStatus;

/// Structure representing an association between a managed thing and an account
/// association, which connects a device to a third-party account.
pub const ManagedThingAssociation = struct {
    /// The identifier of the account association in the association.
    account_association_id: ?[]const u8,

    /// The status of the registration between the managed thing and the account
    /// association. Indicates whether the device is pre-associated or fully
    /// associated with the account association.
    managed_thing_association_status: ?ManagedThingAssociationStatus,

    /// The identifier of the managed thing in the association.
    managed_thing_id: ?[]const u8,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .managed_thing_association_status = "ManagedThingAssociationStatus",
        .managed_thing_id = "ManagedThingId",
    };
};
