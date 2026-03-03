const std = @import("std");

pub const TargetGroupType = enum {
    /// Indicates targets in this target group are IP
    ip,
    /// Indicates targets in this target group are Lambda
    lambda,
    /// Indicates targets in this target group are EC2 instances
    instance,
    /// Indicates target in this target group is an ALB
    alb,

    pub const json_field_names = .{
        .ip = "IP",
        .lambda = "LAMBDA",
        .instance = "INSTANCE",
        .alb = "ALB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ip => "IP",
            .lambda => "LAMBDA",
            .instance => "INSTANCE",
            .alb => "ALB",
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
