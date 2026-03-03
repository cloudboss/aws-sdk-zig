const std = @import("std");

pub const PermissionGroupMembershipStatus = enum {
    addition_in_progress,
    addition_success,
    removal_in_progress,

    pub const json_field_names = .{
        .addition_in_progress = "ADDITION_IN_PROGRESS",
        .addition_success = "ADDITION_SUCCESS",
        .removal_in_progress = "REMOVAL_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .addition_in_progress => "ADDITION_IN_PROGRESS",
            .addition_success => "ADDITION_SUCCESS",
            .removal_in_progress => "REMOVAL_IN_PROGRESS",
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
