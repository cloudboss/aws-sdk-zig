const std = @import("std");

pub const BootModeValues = enum {
    legacy_bios,
    uefi,
    uefi_preferred,

    pub const json_field_names = .{
        .legacy_bios = "legacy-bios",
        .uefi = "uefi",
        .uefi_preferred = "uefi-preferred",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .legacy_bios => "legacy-bios",
            .uefi => "uefi",
            .uefi_preferred => "uefi-preferred",
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
