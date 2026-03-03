const std = @import("std");

/// Burn In Destination Subtitle Rows
pub const BurnInDestinationSubtitleRows = enum {
    rows_16,
    rows_20,
    rows_24,

    pub const json_field_names = .{
        .rows_16 = "ROWS_16",
        .rows_20 = "ROWS_20",
        .rows_24 = "ROWS_24",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rows_16 => "ROWS_16",
            .rows_20 => "ROWS_20",
            .rows_24 => "ROWS_24",
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
