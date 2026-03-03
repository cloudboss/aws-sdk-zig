const std = @import("std");

/// Used in UpdateNodeStateRequest.
pub const UpdateNodeStateShape = enum {
    active,
    draining,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draining = "DRAINING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .draining => "DRAINING",
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
