const std = @import("std");

pub const LicenseModel = enum {
    bring_your_own_license,
    license_included,

    pub const json_field_names = .{
        .bring_your_own_license = "BRING_YOUR_OWN_LICENSE",
        .license_included = "LICENSE_INCLUDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bring_your_own_license => "BRING_YOUR_OWN_LICENSE",
            .license_included => "LICENSE_INCLUDED",
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
