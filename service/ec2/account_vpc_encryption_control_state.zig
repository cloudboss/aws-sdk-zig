const std = @import("std");

pub const AccountVpcEncryptionControlState = enum {
    default_state,
    transitions_in_progress,
    transitions_partially_successful,
    transitions_successful,
    transitions_failed,

    pub const json_field_names = .{
        .default_state = "default-state",
        .transitions_in_progress = "transitions-in-progress",
        .transitions_partially_successful = "transitions-partially-successful",
        .transitions_successful = "transitions-successful",
        .transitions_failed = "transitions-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_state => "default-state",
            .transitions_in_progress => "transitions-in-progress",
            .transitions_partially_successful => "transitions-partially-successful",
            .transitions_successful => "transitions-successful",
            .transitions_failed => "transitions-failed",
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
