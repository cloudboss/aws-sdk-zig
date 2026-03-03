const std = @import("std");

pub const LicenseModel = enum {
    license_included,
    bring_your_own_license,

    pub const json_field_names = .{
        .license_included = "LicenseIncluded",
        .bring_your_own_license = "BringYourOwnLicense",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .license_included => "LicenseIncluded",
            .bring_your_own_license => "BringYourOwnLicense",
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
