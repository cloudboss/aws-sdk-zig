const std = @import("std");

/// Input Loss Action For Ms Smooth Out
pub const InputLossActionForMsSmoothOut = enum {
    emit_output,
    pause_output,

    pub const json_field_names = .{
        .emit_output = "EMIT_OUTPUT",
        .pause_output = "PAUSE_OUTPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .emit_output => "EMIT_OUTPUT",
            .pause_output => "PAUSE_OUTPUT",
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
