const std = @import("std");

pub const CaEnrollmentPolicyStatus = enum {
    in_progress,
    success,
    failed,
    disabling,
    disabled,
    impaired,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .success = "Success",
        .failed = "Failed",
        .disabling = "Disabling",
        .disabled = "Disabled",
        .impaired = "Impaired",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "InProgress",
            .success => "Success",
            .failed => "Failed",
            .disabling => "Disabling",
            .disabled => "Disabled",
            .impaired => "Impaired",
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
