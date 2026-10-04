const std = @import("std");

/// Reference point against which the connection threshold is measured.
pub const ConnectionStartPoint = enum {
    /// Threshold measured from when the contact connects to the telephony system.
    connected_to_system,
    /// Threshold measured from when the customer-side greeting begins.
    greeting_start,
    /// Threshold measured from when the customer-side greeting ends.
    greeting_end,

    pub const json_field_names = .{
        .connected_to_system = "CONNECTED_TO_SYSTEM",
        .greeting_start = "GREETING_START",
        .greeting_end = "GREETING_END",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connected_to_system => "CONNECTED_TO_SYSTEM",
            .greeting_start => "GREETING_START",
            .greeting_end => "GREETING_END",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
