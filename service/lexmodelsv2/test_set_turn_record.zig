const TurnSpecification = @import("turn_specification.zig").TurnSpecification;

/// Contains information about a turn in a test set.
pub const TestSetTurnRecord = struct {
    /// The unique identifier for the conversation associated with the turn.
    conversation_id: ?[]const u8 = null,

    /// The record number associated with the turn.
    record_number: i64,

    /// The number of turns that has elapsed up to that turn.
    turn_number: ?i32 = null,

    /// Contains information about the agent or user turn depending upon type of
    /// turn.
    turn_specification: TurnSpecification,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .record_number = "recordNumber",
        .turn_number = "turnNumber",
        .turn_specification = "turnSpecification",
    };
};
