const std = @import("std");

pub const JobReportScope = enum {
    all_tasks,
    failed_tasks_only,

    pub const json_field_names = .{
        .all_tasks = "AllTasks",
        .failed_tasks_only = "FailedTasksOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_tasks => "AllTasks",
            .failed_tasks_only => "FailedTasksOnly",
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
