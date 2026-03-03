const std = @import("std");

pub const DataLabelOverlap = enum {
    disable_overlap,
    enable_overlap,

    pub const json_field_names = .{
        .disable_overlap = "DISABLE_OVERLAP",
        .enable_overlap = "ENABLE_OVERLAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disable_overlap => "DISABLE_OVERLAP",
            .enable_overlap => "ENABLE_OVERLAP",
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
