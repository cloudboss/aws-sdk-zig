const std = @import("std");

pub const FleetStatus = enum {
    new,
    downloading,
    validating,
    building,
    activating,
    active,
    deleting,
    @"error",
    terminated,
    not_found,

    pub const json_field_names = .{
        .new = "NEW",
        .downloading = "DOWNLOADING",
        .validating = "VALIDATING",
        .building = "BUILDING",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .@"error" = "ERROR",
        .terminated = "TERMINATED",
        .not_found = "NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new => "NEW",
            .downloading => "DOWNLOADING",
            .validating => "VALIDATING",
            .building => "BUILDING",
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .@"error" => "ERROR",
            .terminated => "TERMINATED",
            .not_found => "NOT_FOUND",
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
