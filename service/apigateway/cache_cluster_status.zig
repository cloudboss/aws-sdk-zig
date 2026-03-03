const std = @import("std");

/// Returns the status of the CacheCluster.
pub const CacheClusterStatus = enum {
    create_in_progress,
    available,
    delete_in_progress,
    not_available,
    flush_in_progress,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .available = "AVAILABLE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .not_available = "NOT_AVAILABLE",
        .flush_in_progress = "FLUSH_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .available => "AVAILABLE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .not_available => "NOT_AVAILABLE",
            .flush_in_progress => "FLUSH_IN_PROGRESS",
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
