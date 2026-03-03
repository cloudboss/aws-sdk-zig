const std = @import("std");

pub const ParticipantTimerType = enum {
    idle,
    disconnect_noncustomer,

    pub const json_field_names = .{
        .idle = "IDLE",
        .disconnect_noncustomer = "DISCONNECT_NONCUSTOMER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .idle => "IDLE",
            .disconnect_noncustomer => "DISCONNECT_NONCUSTOMER",
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
