const std = @import("std");

pub const ProcessorParameterName = enum {
    lambda_arn,
    lambda_number_of_retries,
    metadata_extraction_query,
    json_parsing_engine,
    role_arn,
    buffer_size_in_mb,
    buffer_interval_in_seconds,
    sub_record_type,
    delimiter,
    compression_format,
    data_message_extraction,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
        .lambda_number_of_retries = "NumberOfRetries",
        .metadata_extraction_query = "MetadataExtractionQuery",
        .json_parsing_engine = "JsonParsingEngine",
        .role_arn = "RoleArn",
        .buffer_size_in_mb = "BufferSizeInMBs",
        .buffer_interval_in_seconds = "BufferIntervalInSeconds",
        .sub_record_type = "SubRecordType",
        .delimiter = "Delimiter",
        .compression_format = "CompressionFormat",
        .data_message_extraction = "DataMessageExtraction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lambda_arn => "LambdaArn",
            .lambda_number_of_retries => "NumberOfRetries",
            .metadata_extraction_query => "MetadataExtractionQuery",
            .json_parsing_engine => "JsonParsingEngine",
            .role_arn => "RoleArn",
            .buffer_size_in_mb => "BufferSizeInMBs",
            .buffer_interval_in_seconds => "BufferIntervalInSeconds",
            .sub_record_type => "SubRecordType",
            .delimiter => "Delimiter",
            .compression_format => "CompressionFormat",
            .data_message_extraction => "DataMessageExtraction",
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
