const std = @import("std");

pub const TrafficDistributionGroupStatus = enum {
    creation_in_progress,
    active,
    creation_failed,
    pending_deletion,
    deletion_failed,
    update_in_progress,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .active = "ACTIVE",
        .creation_failed = "CREATION_FAILED",
        .pending_deletion = "PENDING_DELETION",
        .deletion_failed = "DELETION_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_in_progress => "CREATION_IN_PROGRESS",
            .active => "ACTIVE",
            .creation_failed => "CREATION_FAILED",
            .pending_deletion => "PENDING_DELETION",
            .deletion_failed => "DELETION_FAILED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
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
