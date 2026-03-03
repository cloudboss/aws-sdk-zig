const std = @import("std");

pub const UpdateActionStatus = enum {
    not_applied,
    waiting_to_start,
    in_progress,
    stopping,
    stopped,
    complete,
    scheduling,
    scheduled,
    not_applicable,

    pub const json_field_names = .{
        .not_applied = "not-applied",
        .waiting_to_start = "waiting-to-start",
        .in_progress = "in-progress",
        .stopping = "stopping",
        .stopped = "stopped",
        .complete = "complete",
        .scheduling = "scheduling",
        .scheduled = "scheduled",
        .not_applicable = "not-applicable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_applied => "not-applied",
            .waiting_to_start => "waiting-to-start",
            .in_progress => "in-progress",
            .stopping => "stopping",
            .stopped => "stopped",
            .complete => "complete",
            .scheduling => "scheduling",
            .scheduled => "scheduled",
            .not_applicable => "not-applicable",
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
