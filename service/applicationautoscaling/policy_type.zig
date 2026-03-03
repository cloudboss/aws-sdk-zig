const std = @import("std");

pub const PolicyType = enum {
    step_scaling,
    target_tracking_scaling,
    predictive_scaling,

    pub const json_field_names = .{
        .step_scaling = "StepScaling",
        .target_tracking_scaling = "TargetTrackingScaling",
        .predictive_scaling = "PredictiveScaling",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .step_scaling => "StepScaling",
            .target_tracking_scaling => "TargetTrackingScaling",
            .predictive_scaling => "PredictiveScaling",
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
