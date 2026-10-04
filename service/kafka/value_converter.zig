const std = @import("std");

/// The deserialization format applied to Apache Kafka record values.
pub const ValueConverter = enum {
    byte_array,
    json,
    json_schema_gsr,
    string,

    pub const json_field_names = .{
        .byte_array = "BYTE_ARRAY",
        .json = "JSON",
        .json_schema_gsr = "JSON_SCHEMA_GSR",
        .string = "STRING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .byte_array => "BYTE_ARRAY",
            .json => "JSON",
            .json_schema_gsr => "JSON_SCHEMA_GSR",
            .string => "STRING",
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
