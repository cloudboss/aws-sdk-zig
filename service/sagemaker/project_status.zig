const std = @import("std");

pub const ProjectStatus = enum {
    pending,
    create_in_progress,
    create_completed,
    create_failed,
    delete_in_progress,
    delete_failed,
    delete_completed,
    update_in_progress,
    update_completed,
    update_failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .create_in_progress = "CreateInProgress",
        .create_completed = "CreateCompleted",
        .create_failed = "CreateFailed",
        .delete_in_progress = "DeleteInProgress",
        .delete_failed = "DeleteFailed",
        .delete_completed = "DeleteCompleted",
        .update_in_progress = "UpdateInProgress",
        .update_completed = "UpdateCompleted",
        .update_failed = "UpdateFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .create_in_progress => "CreateInProgress",
            .create_completed => "CreateCompleted",
            .create_failed => "CreateFailed",
            .delete_in_progress => "DeleteInProgress",
            .delete_failed => "DeleteFailed",
            .delete_completed => "DeleteCompleted",
            .update_in_progress => "UpdateInProgress",
            .update_completed => "UpdateCompleted",
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
