const std = @import("std");

pub const DeploymentStatus = enum {
    pending_update,
    in_progress,
    completed,
    not_eligible,
    eligible,

    pub const json_field_names = .{
        .pending_update = "PENDING_UPDATE",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .not_eligible = "NOT_ELIGIBLE",
        .eligible = "ELIGIBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_update => "PENDING_UPDATE",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .not_eligible => "NOT_ELIGIBLE",
            .eligible => "ELIGIBLE",
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
