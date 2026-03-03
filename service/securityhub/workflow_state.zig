const std = @import("std");

pub const WorkflowState = enum {
    new,
    assigned,
    in_progress,
    deferred,
    resolved,

    pub const json_field_names = .{
        .new = "NEW",
        .assigned = "ASSIGNED",
        .in_progress = "IN_PROGRESS",
        .deferred = "DEFERRED",
        .resolved = "RESOLVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new => "NEW",
            .assigned => "ASSIGNED",
            .in_progress => "IN_PROGRESS",
            .deferred => "DEFERRED",
            .resolved => "RESOLVED",
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
