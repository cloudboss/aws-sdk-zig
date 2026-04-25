const std = @import("std");

pub const RegionToRunIn = enum {
    activating_region,
    deactivating_region,
    active_region,
    inactive_region,

    pub const json_field_names = .{
        .activating_region = "activatingRegion",
        .deactivating_region = "deactivatingRegion",
        .active_region = "activeRegion",
        .inactive_region = "inactiveRegion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activating_region => "activatingRegion",
            .deactivating_region => "deactivatingRegion",
            .active_region => "activeRegion",
            .inactive_region => "inactiveRegion",
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
