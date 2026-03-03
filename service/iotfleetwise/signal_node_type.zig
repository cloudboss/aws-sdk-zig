const std = @import("std");

pub const SignalNodeType = enum {
    sensor,
    actuator,
    attribute,
    branch,
    custom_struct,
    custom_property,

    pub const json_field_names = .{
        .sensor = "SENSOR",
        .actuator = "ACTUATOR",
        .attribute = "ATTRIBUTE",
        .branch = "BRANCH",
        .custom_struct = "CUSTOM_STRUCT",
        .custom_property = "CUSTOM_PROPERTY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sensor => "SENSOR",
            .actuator => "ACTUATOR",
            .attribute => "ATTRIBUTE",
            .branch => "BRANCH",
            .custom_struct => "CUSTOM_STRUCT",
            .custom_property => "CUSTOM_PROPERTY",
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
