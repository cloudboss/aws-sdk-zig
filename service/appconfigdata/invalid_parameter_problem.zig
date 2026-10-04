const std = @import("std");

pub const InvalidParameterProblem = enum {
    /// The parameter was corrupted and could not be understood by the service.
    corrupted,
    /// The parameter was expired and can no longer be used.
    expired,
    /// The client called the service before the time specified in the poll
    /// interval.
    poll_interval_not_satisfied,

    pub const json_field_names = .{
        .corrupted = "Corrupted",
        .expired = "Expired",
        .poll_interval_not_satisfied = "PollIntervalNotSatisfied",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .corrupted => "Corrupted",
            .expired => "Expired",
            .poll_interval_not_satisfied => "PollIntervalNotSatisfied",
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
