const std = @import("std");

pub const DiagnosticsMode = enum {
    off,
    send_active_dtcs,

    pub const json_field_names = .{
        .off = "OFF",
        .send_active_dtcs = "SEND_ACTIVE_DTCS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "OFF",
            .send_active_dtcs => "SEND_ACTIVE_DTCS",
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
