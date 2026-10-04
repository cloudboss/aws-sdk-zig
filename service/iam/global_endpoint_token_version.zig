const std = @import("std");

pub const globalEndpointTokenVersion = enum {
    v_1_token,
    v_2_token,

    pub const json_field_names = .{
        .v_1_token = "v1Token",
        .v_2_token = "v2Token",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v_1_token => "v1Token",
            .v_2_token => "v2Token",
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
