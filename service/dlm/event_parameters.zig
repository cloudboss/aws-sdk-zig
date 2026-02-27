const EventTypeValues = @import("event_type_values.zig").EventTypeValues;

/// **[Event-based policies only]** Specifies an event that activates an
/// event-based policy.
pub const EventParameters = struct {
    /// The snapshot description that can trigger the policy. The description
    /// pattern is specified using
    /// a regular expression. The policy runs only if a snapshot with a description
    /// that matches the
    /// specified pattern is shared with your account.
    ///
    /// For example, specifying `^.*Created for policy: policy-1234567890abcdef0.*$`
    /// configures the policy to run only if snapshots created by policy
    /// `policy-1234567890abcdef0`
    /// are shared with your account.
    description_regex: []const u8,

    /// The type of event. Currently, only snapshot sharing events are supported.
    event_type: EventTypeValues,

    /// The IDs of the Amazon Web Services accounts that can trigger policy by
    /// sharing snapshots with your account.
    /// The policy only runs if one of the specified Amazon Web Services accounts
    /// shares a snapshot with your account.
    snapshot_owner: []const []const u8,

    pub const json_field_names = .{
        .description_regex = "DescriptionRegex",
        .event_type = "EventType",
        .snapshot_owner = "SnapshotOwner",
    };
};
