const std = @import("std");

/// The type of storage used for a mount inside the container.
pub const MountStorageType = enum {
    shared_storage,

    pub const json_field_names = .{
        .shared_storage = "SHARED_STORAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .shared_storage => "SHARED_STORAGE",
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
