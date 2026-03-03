const std = @import("std");

pub const DeploymentState = enum {
    baking,
    validating,
    deploying,
    complete,
    rolling_back,
    rolled_back,
    reverted,

    pub const json_field_names = .{
        .baking = "BAKING",
        .validating = "VALIDATING",
        .deploying = "DEPLOYING",
        .complete = "COMPLETE",
        .rolling_back = "ROLLING_BACK",
        .rolled_back = "ROLLED_BACK",
        .reverted = "REVERTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .baking => "BAKING",
            .validating => "VALIDATING",
            .deploying => "DEPLOYING",
            .complete => "COMPLETE",
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
