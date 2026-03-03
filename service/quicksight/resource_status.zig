const std = @import("std");

pub const ResourceStatus = enum {
    creation_in_progress,
    creation_successful,
    creation_failed,
    update_in_progress,
    update_successful,
    update_failed,
    deleted,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_successful = "CREATION_SUCCESSFUL",
        .creation_failed = "CREATION_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_successful = "UPDATE_SUCCESSFUL",
        .update_failed = "UPDATE_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_in_progress => "CREATION_IN_PROGRESS",
            .creation_successful => "CREATION_SUCCESSFUL",
            .creation_failed => "CREATION_FAILED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_successful => "UPDATE_SUCCESSFUL",
            .update_failed => "UPDATE_FAILED",
            .deleted => "DELETED",
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
