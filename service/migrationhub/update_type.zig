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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
