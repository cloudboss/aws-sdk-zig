const std = @import("std");

pub const DestinationType = enum {
    cloud_watch_logs,
    kinesis_firehose,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudwatch-logs",
        .kinesis_firehose = "kinesis-firehose",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud_watch_logs => "cloudwatch-logs",
            .kinesis_firehose => "kinesis-firehose",
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
