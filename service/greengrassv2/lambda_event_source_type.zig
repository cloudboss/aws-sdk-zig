const std = @import("std");

pub const LambdaEventSourceType = enum {
    pub_sub,
    iot_core,

    pub const json_field_names = .{
        .pub_sub = "PUB_SUB",
        .iot_core = "IOT_CORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pub_sub => "PUB_SUB",
            .iot_core => "IOT_CORE",
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
