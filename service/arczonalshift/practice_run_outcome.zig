const std = @import("std");

pub const PracticeRunOutcome = enum {
    failed,
    interrupted,
    pending,
    succeeded,
    capacity_check_failed,

    pub const json_field_names = .{
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .capacity_check_failed = "CAPACITY_CHECK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "FAILED",
            .interrupted => "INTERRUPTED",
            .pending => "PENDING",
            .succeeded => "SUCCEEDED",
            .capacity_check_failed => "CAPACITY_CHECK_FAILED",
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
