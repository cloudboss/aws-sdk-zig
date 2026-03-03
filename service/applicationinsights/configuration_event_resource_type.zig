const std = @import("std");

pub const ConfigurationEventResourceType = enum {
    cloudwatch_alarm,
    cloudwatch_log,
    cloudformation,
    ssm_association,

    pub const json_field_names = .{
        .cloudwatch_alarm = "CLOUDWATCH_ALARM",
        .cloudwatch_log = "CLOUDWATCH_LOG",
        .cloudformation = "CLOUDFORMATION",
        .ssm_association = "SSM_ASSOCIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudwatch_alarm => "CLOUDWATCH_ALARM",
            .cloudwatch_log => "CLOUDWATCH_LOG",
            .cloudformation => "CLOUDFORMATION",
            .ssm_association => "SSM_ASSOCIATION",
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
