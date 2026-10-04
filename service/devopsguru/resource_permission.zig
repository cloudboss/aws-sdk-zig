const std = @import("std");

pub const ResourcePermission = enum {
    full_permission,
    missing_permission,

    pub const json_field_names = .{
        .full_permission = "FULL_PERMISSION",
        .missing_permission = "MISSING_PERMISSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_permission => "FULL_PERMISSION",
            .missing_permission => "MISSING_PERMISSION",
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
