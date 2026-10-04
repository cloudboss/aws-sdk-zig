const std = @import("std");

pub const StreamGroupStatus = enum {
    activating,
    updating_locations,
    active,
    active_with_errors,
    @"error",
    deleting,
    expired,

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .updating_locations = "UPDATING_LOCATIONS",
        .active = "ACTIVE",
        .active_with_errors = "ACTIVE_WITH_ERRORS",
        .@"error" = "ERROR",
        .deleting = "DELETING",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activating => "ACTIVATING",
            .updating_locations => "UPDATING_LOCATIONS",
            .active => "ACTIVE",
            .active_with_errors => "ACTIVE_WITH_ERRORS",
            .@"error" => "ERROR",
            .deleting => "DELETING",
            .expired => "EXPIRED",
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
