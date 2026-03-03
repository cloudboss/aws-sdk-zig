const std = @import("std");

pub const MembershipStatus = enum {
    active,
    removed,
    collaboration_deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .removed = "REMOVED",
        .collaboration_deleted = "COLLABORATION_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .removed => "REMOVED",
            .collaboration_deleted => "COLLABORATION_DELETED",
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
