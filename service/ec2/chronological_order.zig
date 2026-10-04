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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
