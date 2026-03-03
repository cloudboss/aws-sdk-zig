const std = @import("std");

pub const Validation = enum {
    enable,
    disable,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enable = "ENABLE",
        .disable = "DISABLE",
        .use_local_resource_setting = "USE_LOCAL_RESOURCE_SETTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enable => "ENABLE",
            .disable => "DISABLE",
            .use_local_resource_setting => "USE_LOCAL_RESOURCE_SETTING",
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
