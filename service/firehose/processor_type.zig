const std = @import("std");

pub const ProcessorType = enum {
    record_de_aggregation,
    decompression,
    cloud_watch_log_processing,
    lambda,
    metadata_extraction,
    append_delimiter_to_record,

    pub const json_field_names = .{
        .record_de_aggregation = "RecordDeAggregation",
        .decompression = "Decompression",
        .cloud_watch_log_processing = "CloudWatchLogProcessing",
        .lambda = "Lambda",
        .metadata_extraction = "MetadataExtraction",
        .append_delimiter_to_record = "AppendDelimiterToRecord",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .record_de_aggregation => "RecordDeAggregation",
            .decompression => "Decompression",
            .cloud_watch_log_processing => "CloudWatchLogProcessing",
            .lambda => "Lambda",
            .metadata_extraction => "MetadataExtraction",
            .append_delimiter_to_record => "AppendDelimiterToRecord",
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
