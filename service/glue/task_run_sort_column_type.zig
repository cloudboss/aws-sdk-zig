const std = @import("std");

pub const TaskRunSortColumnType = enum {
    task_run_type,
    status,
    started,

    pub const json_field_names = .{
        .task_run_type = "TASK_RUN_TYPE",
        .status = "STATUS",
        .started = "STARTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .task_run_type => "TASK_RUN_TYPE",
            .status => "STATUS",
            .started => "STARTED",
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
