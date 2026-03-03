const std = @import("std");

pub const LogDriver = enum {
    json_file,
    syslog,
    journald,
    gelf,
    fluentd,
    awslogs,
    splunk,
    awsfirelens,

    pub const json_field_names = .{
        .json_file = "json-file",
        .syslog = "syslog",
        .journald = "journald",
        .gelf = "gelf",
        .fluentd = "fluentd",
        .awslogs = "awslogs",
        .splunk = "splunk",
        .awsfirelens = "awsfirelens",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json_file => "json-file",
            .syslog => "syslog",
            .journald => "journald",
            .gelf => "gelf",
            .fluentd => "fluentd",
            .awslogs => "awslogs",
            .splunk => "splunk",
            .awsfirelens => "awsfirelens",
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
