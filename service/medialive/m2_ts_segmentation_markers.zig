const std = @import("std");

/// M2ts Segmentation Markers
pub const M2tsSegmentationMarkers = enum {
    ebp,
    ebp_legacy,
    none,
    psi_segstart,
    rai_adapt,
    rai_segstart,

    pub const json_field_names = .{
        .ebp = "EBP",
        .ebp_legacy = "EBP_LEGACY",
        .none = "NONE",
        .psi_segstart = "PSI_SEGSTART",
        .rai_adapt = "RAI_ADAPT",
        .rai_segstart = "RAI_SEGSTART",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ebp => "EBP",
            .ebp_legacy => "EBP_LEGACY",
            .none => "NONE",
            .psi_segstart => "PSI_SEGSTART",
            .rai_adapt => "RAI_ADAPT",
            .rai_segstart => "RAI_SEGSTART",
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
