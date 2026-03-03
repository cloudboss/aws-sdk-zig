const std = @import("std");

/// Ms Smooth H265 Packaging Type
pub const MsSmoothH265PackagingType = enum {
    hev1,
    hvc1,

    pub const json_field_names = .{
        .hev1 = "HEV1",
        .hvc1 = "HVC1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hev1 => "HEV1",
            .hvc1 => "HVC1",
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
