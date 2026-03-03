const std = @import("std");

pub const AccountAttributeName = enum {
    account_tier,
    default_protect_configuration_id,

    pub const json_field_names = .{
        .account_tier = "ACCOUNT_TIER",
        .default_protect_configuration_id = "DEFAULT_PROTECT_CONFIGURATION_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_tier => "ACCOUNT_TIER",
            .default_protect_configuration_id => "DEFAULT_PROTECT_CONFIGURATION_ID",
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
