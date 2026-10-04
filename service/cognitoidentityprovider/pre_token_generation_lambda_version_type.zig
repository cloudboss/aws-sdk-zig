const std = @import("std");

pub const PreTokenGenerationLambdaVersionType = enum {
    v1_0,
    v2_0,
    v3_0,

    pub const json_field_names = .{
        .v1_0 = "V1_0",
        .v2_0 = "V2_0",
        .v3_0 = "V3_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v1_0 => "V1_0",
            .v2_0 => "V2_0",
            .v3_0 => "V3_0",
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
