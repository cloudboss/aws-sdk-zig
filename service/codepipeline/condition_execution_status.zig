const std = @import("std");

pub const ConditionExecutionStatus = enum {
    in_progress,
    failed,
    errored,
    succeeded,
    cancelled,
    abandoned,
    overridden,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .failed = "Failed",
        .errored = "Errored",
        .succeeded = "Succeeded",
        .cancelled = "Cancelled",
        .abandoned = "Abandoned",
        .overridden = "Overridden",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "InProgress",
            .failed => "Failed",
            .errored => "Errored",
            .succeeded => "Succeeded",
            .cancelled => "Cancelled",
            .abandoned => "Abandoned",
            .overridden => "Overridden",
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
