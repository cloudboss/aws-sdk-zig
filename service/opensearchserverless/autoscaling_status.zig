const std = @import("std");

/// The autoscaling status of an OpenSearch Serverless collection group:
/// `ACTION_SCALING_UP`, `ACTION_SCALING_DOWN`, or `NO_ACTION`.
pub const AutoscalingStatus = enum {
    action_scaling_up,
    action_scaling_down,
    no_action,

    pub const json_field_names = .{
        .action_scaling_up = "ACTION_SCALING_UP",
        .action_scaling_down = "ACTION_SCALING_DOWN",
        .no_action = "NO_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_scaling_up => "ACTION_SCALING_UP",
            .action_scaling_down => "ACTION_SCALING_DOWN",
            .no_action => "NO_ACTION",
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
