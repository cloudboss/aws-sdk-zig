const std = @import("std");

pub const VolumeFilterName = enum {
    file_system_id,
    storage_virtual_machine_id,

    pub const json_field_names = .{
        .file_system_id = "file-system-id",
        .storage_virtual_machine_id = "storage-virtual-machine-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_id => "file-system-id",
            .storage_virtual_machine_id => "storage-virtual-machine-id",
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
