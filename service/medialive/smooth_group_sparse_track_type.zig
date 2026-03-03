const std = @import("std");

/// Smooth Group Sparse Track Type
pub const SmoothGroupSparseTrackType = enum {
    none,
    scte_35,
    scte_35_without_segmentation,

    pub const json_field_names = .{
        .none = "NONE",
        .scte_35 = "SCTE_35",
        .scte_35_without_segmentation = "SCTE_35_WITHOUT_SEGMENTATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .scte_35 => "SCTE_35",
            .scte_35_without_segmentation => "SCTE_35_WITHOUT_SEGMENTATION",
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
