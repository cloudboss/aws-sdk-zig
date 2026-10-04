const std = @import("std");

/// Input Loss Action For Rtmp Out
pub const InputLossActionForRtmpOut = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
