const std = @import("std");

pub const ActivationStatus = enum {
    activated,
    not_activated,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .not_activated = "NOT_ACTIVATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activated => "ACTIVATED",
            .not_activated => "NOT_ACTIVATED",
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
