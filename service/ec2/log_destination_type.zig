const std = @import("std");

pub const LogDestinationType = enum {
    cloud_watch_logs,
    s_3,
    kinesis_data_firehose,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloud-watch-logs",
        .s_3 = "s3",
        .kinesis_data_firehose = "kinesis-data-firehose",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud_watch_logs => "cloud-watch-logs",
            .s_3 => "s3",
            .kinesis_data_firehose => "kinesis-data-firehose",
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
