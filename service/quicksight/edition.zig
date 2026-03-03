const std = @import("std");

pub const Edition = enum {
    standard,
    enterprise,
    enterprise_and_q,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .enterprise = "ENTERPRISE",
        .enterprise_and_q = "ENTERPRISE_AND_Q",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .enterprise => "ENTERPRISE",
            .enterprise_and_q => "ENTERPRISE_AND_Q",
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
