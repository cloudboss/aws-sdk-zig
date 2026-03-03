const std = @import("std");

pub const ServerCertificateStatus = enum {
    invalid,
    valid,

    pub const json_field_names = .{
        .invalid = "INVALID",
        .valid = "VALID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid => "INVALID",
            .valid => "VALID",
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
