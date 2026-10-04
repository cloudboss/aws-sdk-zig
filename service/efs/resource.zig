const std = @import("std");

/// An EFS resource, for example a file system or a mount target.
pub const Resource = enum {
    file_system,
    mount_target,

    pub const json_field_names = .{
        .file_system = "FILE_SYSTEM",
        .mount_target = "MOUNT_TARGET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system => "FILE_SYSTEM",
            .mount_target => "MOUNT_TARGET",
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
