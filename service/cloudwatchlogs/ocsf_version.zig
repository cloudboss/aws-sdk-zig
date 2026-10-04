const std = @import("std");

pub const OCSFVersion = enum {
    v1_1,
    v1_5,

    pub const json_field_names = .{
        .v1_1 = "V1.1",
        .v1_5 = "V1.5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v1_1 => "V1.1",
            .v1_5 => "V1.5",
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
