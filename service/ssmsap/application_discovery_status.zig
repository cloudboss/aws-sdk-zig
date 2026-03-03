const std = @import("std");

pub const ApplicationDiscoveryStatus = enum {
    success,
    registration_failed,
    refresh_failed,
    registering,
    deleting,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .registration_failed = "REGISTRATION_FAILED",
        .refresh_failed = "REFRESH_FAILED",
        .registering = "REGISTERING",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .registration_failed => "REGISTRATION_FAILED",
            .refresh_failed => "REFRESH_FAILED",
            .registering => "REGISTERING",
            .deleting => "DELETING",
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
