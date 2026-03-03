const std = @import("std");

/// Fec Output Include Fec
pub const FecOutputIncludeFec = enum {
    column,
    column_and_row,

    pub const json_field_names = .{
        .column = "COLUMN",
        .column_and_row = "COLUMN_AND_ROW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .column => "COLUMN",
            .column_and_row => "COLUMN_AND_ROW",
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
