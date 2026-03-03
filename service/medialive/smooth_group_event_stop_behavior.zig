const std = @import("std");

/// Smooth Group Event Stop Behavior
pub const SmoothGroupEventStopBehavior = enum {
    none,
    send_eos,

    pub const json_field_names = .{
        .none = "NONE",
        .send_eos = "SEND_EOS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .send_eos => "SEND_EOS",
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
