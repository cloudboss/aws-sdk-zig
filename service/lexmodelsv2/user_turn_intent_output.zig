const aws = @import("aws");

const UserTurnSlotOutput = @import("user_turn_slot_output.zig").UserTurnSlotOutput;

/// Contains information about the intent that is output for the turn by the
/// test execution.
pub const UserTurnIntentOutput = struct {
    /// The name of the intent.
    name: []const u8,

    /// The slots associated with the intent.
    slots: ?[]const aws.map.MapEntry(UserTurnSlotOutput),

    pub const json_field_names = .{
        .name = "name",
        .slots = "slots",
    };
};
