const std = @import("std");

pub const ThirdPartyFirewallAssociationStatus = enum {
    onboarding,
    onboard_complete,
    offboarding,
    offboard_complete,
    not_exist,

    pub const json_field_names = .{
        .onboarding = "ONBOARDING",
        .onboard_complete = "ONBOARD_COMPLETE",
        .offboarding = "OFFBOARDING",
        .offboard_complete = "OFFBOARD_COMPLETE",
        .not_exist = "NOT_EXIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .onboarding => "ONBOARDING",
            .onboard_complete => "ONBOARD_COMPLETE",
            .offboarding => "OFFBOARDING",
            .offboard_complete => "OFFBOARD_COMPLETE",
            .not_exist => "NOT_EXIST",
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
