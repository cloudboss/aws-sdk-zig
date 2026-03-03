const std = @import("std");

pub const SlotValueSelectionStrategy = enum {
    original_value,
    top_resolution,

    pub const json_field_names = .{
        .original_value = "ORIGINAL_VALUE",
        .top_resolution = "TOP_RESOLUTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .original_value => "ORIGINAL_VALUE",
            .top_resolution => "TOP_RESOLUTION",
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
