const std = @import("std");

pub const TargetPlatformAccelerator = enum {
    intel_graphics,
    mali,
    nvidia,
    nna,

    pub const json_field_names = .{
        .intel_graphics = "INTEL_GRAPHICS",
        .mali = "MALI",
        .nvidia = "NVIDIA",
        .nna = "NNA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intel_graphics => "INTEL_GRAPHICS",
            .mali => "MALI",
            .nvidia => "NVIDIA",
            .nna => "NNA",
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
