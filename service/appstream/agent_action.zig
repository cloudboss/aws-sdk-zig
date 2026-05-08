const std = @import("std");

/// The type of agent action.
///
/// * COMPUTER_VISION - Allows agents to take screenshots of the desktop.
///
/// * COMPUTER_INPUT - Allows agents to click, type, and scroll on the desktop.
///   Requires COMPUTER_VISION to also be enabled.
pub const AgentAction = enum {
    computer_vision,
    computer_input,

    pub const json_field_names = .{
        .computer_vision = "COMPUTER_VISION",
        .computer_input = "COMPUTER_INPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .computer_vision => "COMPUTER_VISION",
            .computer_input => "COMPUTER_INPUT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
