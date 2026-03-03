const std = @import("std");

pub const DeploymentOption = enum {
    with_traffic_control,
    without_traffic_control,

    pub const json_field_names = .{
        .with_traffic_control = "WITH_TRAFFIC_CONTROL",
        .without_traffic_control = "WITHOUT_TRAFFIC_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .with_traffic_control => "WITH_TRAFFIC_CONTROL",
            .without_traffic_control => "WITHOUT_TRAFFIC_CONTROL",
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
