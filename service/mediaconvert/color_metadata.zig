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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
