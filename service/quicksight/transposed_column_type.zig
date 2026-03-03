const std = @import("std");

pub const TransposedColumnType = enum {
    row_header_column,
    value_column,

    pub const json_field_names = .{
        .row_header_column = "ROW_HEADER_COLUMN",
        .value_column = "VALUE_COLUMN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .row_header_column => "ROW_HEADER_COLUMN",
            .value_column => "VALUE_COLUMN",
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
