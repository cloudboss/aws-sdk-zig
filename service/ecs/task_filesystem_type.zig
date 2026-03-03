const std = @import("std");

pub const TaskFilesystemType = enum {
    ext3,
    ext4,
    xfs,
    ntfs,

    pub const json_field_names = .{
        .ext3 = "ext3",
        .ext4 = "ext4",
        .xfs = "xfs",
        .ntfs = "ntfs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ext3 => "ext3",
            .ext4 => "ext4",
            .xfs => "xfs",
            .ntfs => "ntfs",
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
