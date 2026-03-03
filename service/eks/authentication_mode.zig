const std = @import("std");

pub const AuthenticationMode = enum {
    api,
    api_and_config_map,
    config_map,

    pub const json_field_names = .{
        .api = "API",
        .api_and_config_map = "API_AND_CONFIG_MAP",
        .config_map = "CONFIG_MAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api => "API",
            .api_and_config_map => "API_AND_CONFIG_MAP",
            .config_map => "CONFIG_MAP",
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
