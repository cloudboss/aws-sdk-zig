const std = @import("std");

pub const RecordFormatType = enum {
    gsr_json,
    json,
    string,
    byte_array,

    pub const json_field_names = .{
        .gsr_json = "GSR_JSON",
        .json = "JSON",
        .string = "STRING",
        .byte_array = "BYTE_ARRAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gsr_json => "GSR_JSON",
            .json => "JSON",
            .string => "STRING",
            .byte_array => "BYTE_ARRAY",
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
