const std = @import("std");

/// Smooth Group Stream Manifest Behavior
pub const SmoothGroupStreamManifestBehavior = enum {
    do_not_send,
    send,

    pub const json_field_names = .{
        .do_not_send = "DO_NOT_SEND",
        .send = "SEND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .do_not_send => "DO_NOT_SEND",
            .send => "SEND",
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
