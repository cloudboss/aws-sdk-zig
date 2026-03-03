const std = @import("std");

pub const ContactState = enum {
    incoming,
    pending,
    connecting,
    connected,
    connected_onhold,
    missed,
    @"error",
    ended,
    rejected,

    pub const json_field_names = .{
        .incoming = "INCOMING",
        .pending = "PENDING",
        .connecting = "CONNECTING",
        .connected = "CONNECTED",
        .connected_onhold = "CONNECTED_ONHOLD",
        .missed = "MISSED",
        .@"error" = "ERROR",
        .ended = "ENDED",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incoming => "INCOMING",
            .pending => "PENDING",
            .connecting => "CONNECTING",
            .connected => "CONNECTED",
            .connected_onhold => "CONNECTED_ONHOLD",
            .missed => "MISSED",
            .@"error" => "ERROR",
            .ended => "ENDED",
            .rejected => "REJECTED",
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
