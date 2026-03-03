const std = @import("std");

pub const SbomReportFormat = enum {
    cyclonedx_1_4,
    spdx_2_3,

    pub const json_field_names = .{
        .cyclonedx_1_4 = "CYCLONEDX_1_4",
        .spdx_2_3 = "SPDX_2_3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cyclonedx_1_4 => "CYCLONEDX_1_4",
            .spdx_2_3 => "SPDX_2_3",
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
