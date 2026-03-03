const std = @import("std");

/// Bandwidth Reduction Post Filter Sharpening
pub const BandwidthReductionPostFilterSharpening = enum {
    disabled,
    sharpening_1,
    sharpening_2,
    sharpening_3,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .sharpening_1 = "SHARPENING_1",
        .sharpening_2 = "SHARPENING_2",
        .sharpening_3 = "SHARPENING_3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .sharpening_1 => "SHARPENING_1",
            .sharpening_2 => "SHARPENING_2",
            .sharpening_3 => "SHARPENING_3",
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
