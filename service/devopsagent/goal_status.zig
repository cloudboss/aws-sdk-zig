const std = @import("std");

/// Possible states of a goal throughout its lifecycle
pub const GoalStatus = enum {
    /// Goal is active and being evaluated according to schedule
    active,
    /// Goal evaluations are temporarily paused
    paused,
    /// Goal has been marked as completed
    complete,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .paused = "PAUSED",
        .complete = "COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .paused => "PAUSED",
            .complete => "COMPLETE",
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
