const std = @import("std");

pub const Ec2AsgCapacityMonitoringApproach = enum {
    sampled_max_in_last_24_hours,
    autoscaling_max_in_last_24_hours,

    pub const json_field_names = .{
        .sampled_max_in_last_24_hours = "sampledMaxInLast24Hours",
        .autoscaling_max_in_last_24_hours = "autoscalingMaxInLast24Hours",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sampled_max_in_last_24_hours => "sampledMaxInLast24Hours",
            .autoscaling_max_in_last_24_hours => "autoscalingMaxInLast24Hours",
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
