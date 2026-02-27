const Action = @import("action.zig").Action;
const Event = @import("event.zig").Event;

/// An event action is an object that defines the relationship between a
/// specific event and
/// an automated action that will be taken on behalf of the customer.
pub const EventActionEntry = struct {
    /// What occurs after a certain event.
    action: Action,

    /// The Amazon Resource Name (ARN) for the event action.
    arn: []const u8,

    /// The date and time that the event action was created, in ISO 8601 format.
    created_at: i64,

    /// What occurs to start an action.
    event: Event,

    /// The unique identifier for the event action.
    id: []const u8,

    /// The date and time that the event action was last updated, in ISO 8601
    /// format.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "Action",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .event = "Event",
        .id = "Id",
        .updated_at = "UpdatedAt",
    };
};
