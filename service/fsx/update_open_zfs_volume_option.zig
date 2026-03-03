const std = @import("std");

pub const UpdateOpenZFSVolumeOption = enum {
    delete_intermediate_snapshots,
    delete_cloned_volumes,
    delete_intermediate_data,

    pub const json_field_names = .{
        .delete_intermediate_snapshots = "DELETE_INTERMEDIATE_SNAPSHOTS",
        .delete_cloned_volumes = "DELETE_CLONED_VOLUMES",
        .delete_intermediate_data = "DELETE_INTERMEDIATE_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete_intermediate_snapshots => "DELETE_INTERMEDIATE_SNAPSHOTS",
            .delete_cloned_volumes => "DELETE_CLONED_VOLUMES",
            .delete_intermediate_data => "DELETE_INTERMEDIATE_DATA",
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
