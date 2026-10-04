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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
