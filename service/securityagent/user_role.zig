const std = @import("std");

/// Role of a user member associated to an agent space.
pub const UserRole = enum {
    /// Default member role with standard permissions.
    member,

    pub const json_field_names = .{
        .member = "MEMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .member => "MEMBER",
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
