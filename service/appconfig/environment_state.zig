const std = @import("std");

pub const EnvironmentState = enum {
    ready_for_deployment,
    deploying,
    rolling_back,
    rolled_back,
    reverted,

    pub const json_field_names = .{
        .ready_for_deployment = "READY_FOR_DEPLOYMENT",
        .deploying = "DEPLOYING",
        .rolling_back = "ROLLING_BACK",
        .rolled_back = "ROLLED_BACK",
        .reverted = "REVERTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready_for_deployment => "READY_FOR_DEPLOYMENT",
            .deploying => "DEPLOYING",
            .rolling_back => "ROLLING_BACK",
            .rolled_back => "ROLLED_BACK",
            .reverted => "REVERTED",
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
