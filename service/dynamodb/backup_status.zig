const std = @import("std");

pub const BackupStatus = enum {
    creating,
    deleted,
    available,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleted = "DELETED",
        .available = "AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .deleted => "DELETED",
            .available => "AVAILABLE",
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
