const std = @import("std");

/// The improvement status for a workload.
pub const WorkloadImprovementStatus = enum {
    not_applicable,
    not_started,
    in_progress,
    complete,
    risk_acknowledged,

    pub const json_field_names = .{
        .not_applicable = "NOT_APPLICABLE",
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .risk_acknowledged = "RISK_ACKNOWLEDGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_applicable => "NOT_APPLICABLE",
            .not_started => "NOT_STARTED",
            .in_progress => "IN_PROGRESS",
            .complete => "COMPLETE",
            .risk_acknowledged => "RISK_ACKNOWLEDGED",
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
