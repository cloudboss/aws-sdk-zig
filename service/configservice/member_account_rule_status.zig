const std = @import("std");

pub const MemberAccountRuleStatus = enum {
    create_successful,
    create_in_progress,
    create_failed,
    delete_successful,
    delete_failed,
    delete_in_progress,
    update_successful,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .create_successful = "CREATE_SUCCESSFUL",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_successful = "DELETE_SUCCESSFUL",
        .delete_failed = "DELETE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .update_successful = "UPDATE_SUCCESSFUL",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_successful => "CREATE_SUCCESSFUL",
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .delete_successful => "DELETE_SUCCESSFUL",
            .delete_failed => "DELETE_FAILED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .update_successful => "UPDATE_SUCCESSFUL",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_failed => "UPDATE_FAILED",
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
