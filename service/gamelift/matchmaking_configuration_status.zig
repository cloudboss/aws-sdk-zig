const std = @import("std");

pub const MatchmakingConfigurationStatus = enum {
    cancelled,
    completed,
    failed,
    placing,
    queued,
    requires_acceptance,
    searching,
    timed_out,

    pub const json_field_names = .{
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .placing = "PLACING",
        .queued = "QUEUED",
        .requires_acceptance = "REQUIRES_ACCEPTANCE",
        .searching = "SEARCHING",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cancelled => "CANCELLED",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .placing => "PLACING",
            .queued => "QUEUED",
            .requires_acceptance => "REQUIRES_ACCEPTANCE",
            .searching => "SEARCHING",
            .timed_out => "TIMED_OUT",
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
