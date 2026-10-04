const std = @import("std");

pub const CallingNameStatus = enum {
    unassigned,
    update_in_progress,
    update_succeeded,
    update_failed,

    pub const json_field_names = .{
        .unassigned = "Unassigned",
        .update_in_progress = "UpdateInProgress",
        .update_succeeded = "UpdateSucceeded",
        .update_failed = "UpdateFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unassigned => "Unassigned",
            .update_in_progress => "UpdateInProgress",
            .update_succeeded => "UpdateSucceeded",
            .update_failed => "UpdateFailed",
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
