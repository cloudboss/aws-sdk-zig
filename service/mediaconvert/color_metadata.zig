const std = @import("std");

/// Choose Insert for this setting to include color metadata in this output.
/// Choose Ignore to exclude color metadata from this output. If you don't
/// specify a value, the service sets this to Insert by default.
pub const ColorMetadata = enum {
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
