const ChangeAction = @import("change_action.zig").ChangeAction;
const ChangeStatus = @import("change_status.zig").ChangeStatus;
const ChangeType = @import("change_type.zig").ChangeType;
const CoreNetworkChangeEventValues = @import("core_network_change_event_values.zig").CoreNetworkChangeEventValues;

/// Describes a core network change event. This can be a change to a segment,
/// attachment, route, etc.
pub const CoreNetworkChangeEvent = struct {
    /// The action taken for the change event.
    action: ?ChangeAction,

    /// The timestamp for an event change in status.
    event_time: ?i64,

    /// Uniquely identifies the path for a change within the changeset. For example,
    /// the `IdentifierPath` for a core network segment change might be
    /// `"CORE_NETWORK_SEGMENT/us-east-1/devsegment"`.
    identifier_path: ?[]const u8,

    /// The status of the core network change event.
    status: ?ChangeStatus,

    /// Describes the type of change event.
    type: ?ChangeType,

    /// Details of the change event.
    values: ?CoreNetworkChangeEventValues,

    pub const json_field_names = .{
        .action = "Action",
        .event_time = "EventTime",
        .identifier_path = "IdentifierPath",
        .status = "Status",
        .type = "Type",
        .values = "Values",
    };
};
