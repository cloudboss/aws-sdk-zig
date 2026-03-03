const std = @import("std");

pub const DeploymentReadyAction = enum {
    continue_deployment,
    stop_deployment,

    pub const json_field_names = .{
        .continue_deployment = "CONTINUE_DEPLOYMENT",
        .stop_deployment = "STOP_DEPLOYMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .continue_deployment => "CONTINUE_DEPLOYMENT",
            .stop_deployment => "STOP_DEPLOYMENT",
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
