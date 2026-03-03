const std = @import("std");

/// Data View Export File Format
pub const ExportFileFormat = enum {
    parquet,
    delimited_text,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .delimited_text = "DELIMITED_TEXT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .parquet => "PARQUET",
            .delimited_text => "DELIMITED_TEXT",
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
