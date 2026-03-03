const AssociationState = @import("association_state.zig").AssociationState;

/// Structure containing information about an account association, including its
/// identifier, state, and related metadata.
pub const AccountAssociationItem = struct {
    /// The unique identifier of the account association.
    account_association_id: []const u8,

    /// The Amazon Resource Name (ARN) of the account association.
    arn: ?[]const u8 = null,

    /// The current state of the account association, indicating its status in the
    /// association lifecycle.
    association_state: AssociationState,

    /// The identifier of the connector destination associated with this account
    /// association.
    connector_destination_id: ?[]const u8 = null,

    /// A description of the account association.
    description: ?[]const u8 = null,

    /// The error message explaining any issues with the account association, if
    /// applicable.
    error_message: ?[]const u8 = null,

    /// The name of the account association.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .arn = "Arn",
        .association_state = "AssociationState",
        .connector_destination_id = "ConnectorDestinationId",
        .description = "Description",
        .error_message = "ErrorMessage",
        .name = "Name",
    };
};
