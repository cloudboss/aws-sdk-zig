const std = @import("std");

pub const AutoRollbackEvent = enum {
    deployment_failure,
    deployment_stop_on_alarm,
    deployment_stop_on_request,

    pub const json_field_names = .{
        .deployment_failure = "DEPLOYMENT_FAILURE",
        .deployment_stop_on_alarm = "DEPLOYMENT_STOP_ON_ALARM",
        .deployment_stop_on_request = "DEPLOYMENT_STOP_ON_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deployment_failure => "DEPLOYMENT_FAILURE",
            .deployment_stop_on_alarm => "DEPLOYMENT_STOP_ON_ALARM",
            .deployment_stop_on_request => "DEPLOYMENT_STOP_ON_REQUEST",
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
