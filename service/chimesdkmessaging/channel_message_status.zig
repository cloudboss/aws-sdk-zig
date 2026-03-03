const std = @import("std");

pub const ChannelMessageStatus = enum {
    sent,
    pending,
    failed,
    denied,

    pub const json_field_names = .{
        .sent = "SENT",
        .pending = "PENDING",
        .failed = "FAILED",
        .denied = "DENIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sent => "SENT",
            .pending => "PENDING",
            .failed => "FAILED",
            .denied => "DENIED",
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
