const std = @import("std");

/// The type of permission a function has to access a resource.
pub const Permission = enum {
    ro,
    rw,

    pub const json_field_names = .{
        .ro = "ro",
        .rw = "rw",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ro => "ro",
            .rw => "rw",
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
