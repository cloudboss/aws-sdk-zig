const std = @import("std");

pub const PackageType = enum {
    txt_dictionary,
    zip_plugin,
    package_license,
    package_config,

    pub const json_field_names = .{
        .txt_dictionary = "TXT-DICTIONARY",
        .zip_plugin = "ZIP-PLUGIN",
        .package_license = "PACKAGE-LICENSE",
        .package_config = "PACKAGE-CONFIG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .txt_dictionary => "TXT-DICTIONARY",
            .zip_plugin => "ZIP-PLUGIN",
            .package_license => "PACKAGE-LICENSE",
            .package_config => "PACKAGE-CONFIG",
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
