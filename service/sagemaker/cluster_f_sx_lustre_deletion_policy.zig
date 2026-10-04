const std = @import("std");

/// The deletion policy for the Amazon FSx for Lustre file system used in the
/// shared environment of restricted instance groups (RIG).
pub const ClusterFSxLustreDeletionPolicy = enum {
    delete_if_not_used,
    keep,

    pub const json_field_names = .{
        .delete_if_not_used = "DeleteIfNotUsed",
        .keep = "Keep",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete_if_not_used => "DeleteIfNotUsed",
            .keep => "Keep",
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
