const std = @import("std");

/// Status of a routing rule
pub const RuleStatus = enum {
    creation_in_progress,
    active,
    update_in_progress,
    deletion_in_progress,
    deleted,
    failed,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .active = "ACTIVE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .deleted = "DELETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_in_progress => "CREATION_IN_PROGRESS",
            .active => "ACTIVE",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .deletion_in_progress => "DELETION_IN_PROGRESS",
            .deleted => "DELETED",
            .failed => "FAILED",
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
