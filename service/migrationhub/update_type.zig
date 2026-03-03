const std = @import("std");

pub const UpdateType = enum {
    migration_task_state_updated,

    pub const json_field_names = .{
        .migration_task_state_updated = "MIGRATION_TASK_STATE_UPDATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .migration_task_state_updated => "MIGRATION_TASK_STATE_UPDATED",
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
