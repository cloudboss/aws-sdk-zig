const std = @import("std");

pub const NodeDataType = enum {
    int8,
    uint8,
    int16,
    uint16,
    int32,
    uint32,
    int64,
    uint64,
    boolean,
    float,
    double,
    string,
    unix_timestamp,
    int8_array,
    uint8_array,
    int16_array,
    uint16_array,
    int32_array,
    uint32_array,
    int64_array,
    uint64_array,
    boolean_array,
    float_array,
    double_array,
    string_array,
    unix_timestamp_array,
    unknown,
    @"struct",
    struct_array,

    pub const json_field_names = .{
        .int8 = "INT8",
        .uint8 = "UINT8",
        .int16 = "INT16",
        .uint16 = "UINT16",
        .int32 = "INT32",
        .uint32 = "UINT32",
        .int64 = "INT64",
        .uint64 = "UINT64",
        .boolean = "BOOLEAN",
        .float = "FLOAT",
        .double = "DOUBLE",
        .string = "STRING",
        .unix_timestamp = "UNIX_TIMESTAMP",
        .int8_array = "INT8_ARRAY",
        .uint8_array = "UINT8_ARRAY",
        .int16_array = "INT16_ARRAY",
        .uint16_array = "UINT16_ARRAY",
        .int32_array = "INT32_ARRAY",
        .uint32_array = "UINT32_ARRAY",
        .int64_array = "INT64_ARRAY",
        .uint64_array = "UINT64_ARRAY",
        .boolean_array = "BOOLEAN_ARRAY",
        .float_array = "FLOAT_ARRAY",
        .double_array = "DOUBLE_ARRAY",
        .string_array = "STRING_ARRAY",
        .unix_timestamp_array = "UNIX_TIMESTAMP_ARRAY",
        .unknown = "UNKNOWN",
        .@"struct" = "STRUCT",
        .struct_array = "STRUCT_ARRAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int8 => "INT8",
            .uint8 => "UINT8",
            .int16 => "INT16",
            .uint16 => "UINT16",
            .int32 => "INT32",
            .uint32 => "UINT32",
            .int64 => "INT64",
            .uint64 => "UINT64",
            .boolean => "BOOLEAN",
            .float => "FLOAT",
            .double => "DOUBLE",
            .string => "STRING",
            .unix_timestamp => "UNIX_TIMESTAMP",
            .int8_array => "INT8_ARRAY",
            .uint8_array => "UINT8_ARRAY",
            .int16_array => "INT16_ARRAY",
            .uint16_array => "UINT16_ARRAY",
            .int32_array => "INT32_ARRAY",
            .uint32_array => "UINT32_ARRAY",
            .int64_array => "INT64_ARRAY",
            .uint64_array => "UINT64_ARRAY",
            .boolean_array => "BOOLEAN_ARRAY",
            .float_array => "FLOAT_ARRAY",
            .double_array => "DOUBLE_ARRAY",
            .string_array => "STRING_ARRAY",
            .unix_timestamp_array => "UNIX_TIMESTAMP_ARRAY",
            .unknown => "UNKNOWN",
            .@"struct" => "STRUCT",
            .struct_array => "STRUCT_ARRAY",
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
