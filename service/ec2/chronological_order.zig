const std = @import("std");

/// The chronological order for returning results.
pub const ChronologicalOrder = enum {
    forward,
    reverse,

    pub const json_field_names = .{
        .forward = "forward",
        .reverse = "reverse",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forward => "forward",
            .reverse => "reverse",
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
