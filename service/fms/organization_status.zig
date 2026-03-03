const std = @import("std");

pub const OrganizationStatus = enum {
    onboarding,
    onboarding_complete,
    offboarding,
    offboarding_complete,

    pub const json_field_names = .{
        .onboarding = "ONBOARDING",
        .onboarding_complete = "ONBOARDING_COMPLETE",
        .offboarding = "OFFBOARDING",
        .offboarding_complete = "OFFBOARDING_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .onboarding => "ONBOARDING",
            .onboarding_complete => "ONBOARDING_COMPLETE",
            .offboarding => "OFFBOARDING",
            .offboarding_complete => "OFFBOARDING_COMPLETE",
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
