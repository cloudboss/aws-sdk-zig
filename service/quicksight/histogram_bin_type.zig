const std = @import("std");

pub const HistogramBinType = enum {
    bin_count,
    bin_width,

    pub const json_field_names = .{
        .bin_count = "BIN_COUNT",
        .bin_width = "BIN_WIDTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bin_count => "BIN_COUNT",
            .bin_width => "BIN_WIDTH",
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
