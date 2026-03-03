const std = @import("std");

pub const GeneratedTemplateStatus = enum {
    create_pending,
    update_pending,
    delete_pending,
    create_in_progress,
    update_in_progress,
    delete_in_progress,
    failed,
    complete,

    pub const json_field_names = .{
        .create_pending = "CREATE_PENDING",
        .update_pending = "UPDATE_PENDING",
        .delete_pending = "DELETE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .failed = "FAILED",
        .complete = "COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_pending => "CREATE_PENDING",
            .update_pending => "UPDATE_PENDING",
            .delete_pending => "DELETE_PENDING",
            .create_in_progress => "CREATE_IN_PROGRESS",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .failed => "FAILED",
            .complete => "COMPLETE",
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
