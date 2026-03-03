const std = @import("std");

pub const TargetAdministrativeOverrideStateEnum = enum {
    unknown,
    no_override,
    zonal_shift_active,
    zonal_shift_delegated_to_dns,

    pub const json_field_names = .{
        .unknown = "unknown",
        .no_override = "no_override",
        .zonal_shift_active = "zonal_shift_active",
        .zonal_shift_delegated_to_dns = "zonal_shift_delegated_to_dns",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "unknown",
            .no_override => "no_override",
            .zonal_shift_active => "zonal_shift_active",
            .zonal_shift_delegated_to_dns => "zonal_shift_delegated_to_dns",
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
