const std = @import("std");

pub const MigrationWorkflowStatusEnum = enum {
    creating,
    not_started,
    creation_failed,
    starting,
    in_progress,
    workflow_failed,
    paused,
    pausing,
    pausing_failed,
    user_attention_required,
    deleting,
    deletion_failed,
    deleted,
    completed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .not_started = "NOT_STARTED",
        .creation_failed = "CREATION_FAILED",
        .starting = "STARTING",
        .in_progress = "IN_PROGRESS",
        .workflow_failed = "WORKFLOW_FAILED",
        .paused = "PAUSED",
        .pausing = "PAUSING",
        .pausing_failed = "PAUSING_FAILED",
        .user_attention_required = "USER_ATTENTION_REQUIRED",
        .deleting = "DELETING",
        .deletion_failed = "DELETION_FAILED",
        .deleted = "DELETED",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .not_started => "NOT_STARTED",
            .creation_failed => "CREATION_FAILED",
            .starting => "STARTING",
            .in_progress => "IN_PROGRESS",
            .workflow_failed => "WORKFLOW_FAILED",
            .paused => "PAUSED",
            .pausing => "PAUSING",
            .pausing_failed => "PAUSING_FAILED",
            .user_attention_required => "USER_ATTENTION_REQUIRED",
            .deleting => "DELETING",
            .deletion_failed => "DELETION_FAILED",
            .deleted => "DELETED",
            .completed => "COMPLETED",
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
