const std = @import("std");

/// Dvb Sdt Output Sdt
pub const DvbSdtOutputSdt = enum {
    sdt_follow,
    sdt_follow_if_present,
    sdt_manual,
    sdt_none,

    pub const json_field_names = .{
        .sdt_follow = "SDT_FOLLOW",
        .sdt_follow_if_present = "SDT_FOLLOW_IF_PRESENT",
        .sdt_manual = "SDT_MANUAL",
        .sdt_none = "SDT_NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sdt_follow => "SDT_FOLLOW",
            .sdt_follow_if_present => "SDT_FOLLOW_IF_PRESENT",
            .sdt_manual => "SDT_MANUAL",
            .sdt_none => "SDT_NONE",
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
