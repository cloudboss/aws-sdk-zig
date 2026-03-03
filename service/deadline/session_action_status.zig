const std = @import("std");

pub const SessionActionStatus = enum {
    assigned,
    running,
    canceling,
    succeeded,
    failed,
    interrupted,
    canceled,
    never_attempted,
    scheduled,
    reclaiming,
    reclaimed,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .running = "RUNNING",
        .canceling = "CANCELING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .canceled = "CANCELED",
        .never_attempted = "NEVER_ATTEMPTED",
        .scheduled = "SCHEDULED",
        .reclaiming = "RECLAIMING",
        .reclaimed = "RECLAIMED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assigned => "ASSIGNED",
            .running => "RUNNING",
            .canceling => "CANCELING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .interrupted => "INTERRUPTED",
            .canceled => "CANCELED",
            .never_attempted => "NEVER_ATTEMPTED",
            .scheduled => "SCHEDULED",
            .reclaiming => "RECLAIMING",
            .reclaimed => "RECLAIMED",
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
