const std = @import("std");

pub const FleetStatus = enum {
    active,
    create_in_progress,
    update_in_progress,
    create_failed,
    update_failed,
    suspended,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .suspended = "SUSPENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .create_in_progress => "CREATE_IN_PROGRESS",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
            .suspended => "SUSPENDED",
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
