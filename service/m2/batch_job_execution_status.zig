const std = @import("std");

pub const BatchJobExecutionStatus = enum {
    submitting,
    holding,
    dispatch,
    running,
    cancelling,
    cancelled,
    succeeded,
    failed,
    purged,
    succeeded_with_warning,

    pub const json_field_names = .{
        .submitting = "Submitting",
        .holding = "Holding",
        .dispatch = "Dispatching",
        .running = "Running",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
        .succeeded = "Succeeded",
        .failed = "Failed",
        .purged = "Purged",
        .succeeded_with_warning = "Succeeded With Warning",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitting => "Submitting",
            .holding => "Holding",
            .dispatch => "Dispatching",
            .running => "Running",
            .cancelling => "Cancelling",
            .cancelled => "Cancelled",
            .succeeded => "Succeeded",
            .failed => "Failed",
            .purged => "Purged",
            .succeeded_with_warning => "Succeeded With Warning",
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
