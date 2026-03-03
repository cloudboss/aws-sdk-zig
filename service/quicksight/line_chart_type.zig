const std = @import("std");

pub const LineChartType = enum {
    line,
    area,
    stacked_area,

    pub const json_field_names = .{
        .line = "LINE",
        .area = "AREA",
        .stacked_area = "STACKED_AREA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .line => "LINE",
            .area => "AREA",
            .stacked_area => "STACKED_AREA",
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
