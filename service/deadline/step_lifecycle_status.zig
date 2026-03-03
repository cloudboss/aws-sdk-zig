const std = @import("std");

pub const StepLifecycleStatus = enum {
    create_complete,
    update_in_progress,
    update_failed,
    update_succeeded,

    pub const json_field_names = .{
        .create_complete = "CREATE_COMPLETE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
        .update_succeeded = "UPDATE_SUCCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_complete => "CREATE_COMPLETE",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_failed => "UPDATE_FAILED",
            .update_succeeded => "UPDATE_SUCCEEDED",
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
