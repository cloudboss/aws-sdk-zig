const std = @import("std");

pub const ScalingPlanStatusCode = enum {
    active,
    active_with_problems,
    creation_in_progress,
    creation_failed,
    deletion_in_progress,
    deletion_failed,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .active = "Active",
        .active_with_problems = "ActiveWithProblems",
        .creation_in_progress = "CreationInProgress",
        .creation_failed = "CreationFailed",
        .deletion_in_progress = "DeletionInProgress",
        .deletion_failed = "DeletionFailed",
        .update_in_progress = "UpdateInProgress",
        .update_failed = "UpdateFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .active_with_problems => "ActiveWithProblems",
            .creation_in_progress => "CreationInProgress",
            .creation_failed => "CreationFailed",
            .deletion_in_progress => "DeletionInProgress",
            .deletion_failed => "DeletionFailed",
            .update_in_progress => "UpdateInProgress",
            .update_failed => "UpdateFailed",
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
