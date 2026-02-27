const ChangeAction = @import("change_action.zig").ChangeAction;
const CoreNetworkChangeValues = @import("core_network_change_values.zig").CoreNetworkChangeValues;
const ChangeType = @import("change_type.zig").ChangeType;

/// Details describing a core network change.
pub const CoreNetworkChange = struct {
    /// The action to take for a core network.
    action: ?ChangeAction,

    /// The resource identifier.
    identifier: ?[]const u8,

    /// Uniquely identifies the path for a change within the changeset. For example,
    /// the `IdentifierPath` for a core network segment change might be
    /// `"CORE_NETWORK_SEGMENT/us-east-1/devsegment"`.
    identifier_path: ?[]const u8,

    /// The new value for a core network
    new_values: ?CoreNetworkChangeValues,

    /// The previous values for a core network.
    previous_values: ?CoreNetworkChangeValues,

    /// The type of change.
    type: ?ChangeType,

    pub const json_field_names = .{
        .action = "Action",
        .identifier = "Identifier",
        .identifier_path = "IdentifierPath",
        .new_values = "NewValues",
        .previous_values = "PreviousValues",
        .type = "Type",
    };
};
