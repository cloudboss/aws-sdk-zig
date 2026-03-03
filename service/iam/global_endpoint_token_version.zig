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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
