const std = @import("std");

pub const StorageType = enum {
    s3,
    kinesis_video_stream,
    kinesis_stream,
    kinesis_firehose,

    pub const json_field_names = .{
        .s3 = "S3",
        .kinesis_video_stream = "KINESIS_VIDEO_STREAM",
        .kinesis_stream = "KINESIS_STREAM",
        .kinesis_firehose = "KINESIS_FIREHOSE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "S3",
            .kinesis_video_stream => "KINESIS_VIDEO_STREAM",
            .kinesis_stream => "KINESIS_STREAM",
            .kinesis_firehose => "KINESIS_FIREHOSE",
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
