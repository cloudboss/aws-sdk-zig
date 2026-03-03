const std = @import("std");

pub const InstanceState = enum {
    registering,
    active,
    deregistering,
    deregistered,
    registration_error,
    deregistration_error,

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .active = "ACTIVE",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .registration_error = "REGISTRATION_ERROR",
        .deregistration_error = "DEREGISTRATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registering => "REGISTERING",
            .active => "ACTIVE",
            .deregistering => "DEREGISTERING",
            .deregistered => "DEREGISTERED",
            .registration_error => "REGISTRATION_ERROR",
            .deregistration_error => "DEREGISTRATION_ERROR",
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
