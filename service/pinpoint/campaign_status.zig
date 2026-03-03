const std = @import("std");

pub const CampaignStatus = enum {
    scheduled,
    executing,
    pending_next_run,
    completed,
    paused,
    deleted,
    invalid,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .executing = "EXECUTING",
        .pending_next_run = "PENDING_NEXT_RUN",
        .completed = "COMPLETED",
        .paused = "PAUSED",
        .deleted = "DELETED",
        .invalid = "INVALID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .executing => "EXECUTING",
            .pending_next_run => "PENDING_NEXT_RUN",
            .completed => "COMPLETED",
            .paused => "PAUSED",
            .deleted => "DELETED",
            .invalid => "INVALID",
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
