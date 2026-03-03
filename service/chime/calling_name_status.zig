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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
