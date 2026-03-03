const std = @import("std");

pub const AuthMechanismValue = enum {
    default,
    mongodb_cr,
    scram_sha_1,

    pub const json_field_names = .{
        .default = "default",
        .mongodb_cr = "mongodb_cr",
        .scram_sha_1 = "scram_sha_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "default",
            .mongodb_cr => "mongodb_cr",
            .scram_sha_1 => "scram_sha_1",
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
