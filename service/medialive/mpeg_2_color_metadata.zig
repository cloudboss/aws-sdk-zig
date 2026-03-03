const std = @import("std");

/// Mpeg2 Color Metadata
pub const Mpeg2ColorMetadata = enum {
    ignore,
    insert,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .insert = "INSERT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignore => "IGNORE",
            .insert => "INSERT",
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
