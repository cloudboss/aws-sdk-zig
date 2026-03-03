const std = @import("std");

pub const SnapshotFilterName = enum {
    file_system_id,
    volume_id,

    pub const json_field_names = .{
        .file_system_id = "file-system-id",
        .volume_id = "volume-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_id => "file-system-id",
            .volume_id => "volume-id",
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
