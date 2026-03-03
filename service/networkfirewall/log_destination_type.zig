const std = @import("std");

pub const LogDestinationType = enum {
    s3,
    cloudwatch_logs,
    kinesis_data_firehose,

    pub const json_field_names = .{
        .s3 = "S3",
        .cloudwatch_logs = "CloudWatchLogs",
        .kinesis_data_firehose = "KinesisDataFirehose",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "S3",
            .cloudwatch_logs => "CloudWatchLogs",
            .kinesis_data_firehose => "KinesisDataFirehose",
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
