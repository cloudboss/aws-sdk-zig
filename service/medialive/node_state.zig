const std = @import("std");

/// Used in DescribeNodeSummary.
pub const NodeState = enum {
    created,
    registering,
    ready_to_activate,
    registration_failed,
    activation_failed,
    active,
    ready,
    in_use,
    deregistering,
    draining,
    deregistration_failed,
    deregistered,

    pub const json_field_names = .{
        .created = "CREATED",
        .registering = "REGISTERING",
        .ready_to_activate = "READY_TO_ACTIVATE",
        .registration_failed = "REGISTRATION_FAILED",
        .activation_failed = "ACTIVATION_FAILED",
        .active = "ACTIVE",
        .ready = "READY",
        .in_use = "IN_USE",
        .deregistering = "DEREGISTERING",
        .draining = "DRAINING",
        .deregistration_failed = "DEREGISTRATION_FAILED",
        .deregistered = "DEREGISTERED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .registering => "REGISTERING",
            .ready_to_activate => "READY_TO_ACTIVATE",
            .registration_failed => "REGISTRATION_FAILED",
            .activation_failed => "ACTIVATION_FAILED",
            .active => "ACTIVE",
            .ready => "READY",
            .in_use => "IN_USE",
            .deregistering => "DEREGISTERING",
            .draining => "DRAINING",
            .deregistration_failed => "DEREGISTRATION_FAILED",
            .deregistered => "DEREGISTERED",
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
