const std = @import("std");

/// Scte35 Type
pub const Scte35Type = enum {
    none,
    scte_35_without_segmentation,
    scte_35_without_idr,

    pub const json_field_names = .{
        .none = "NONE",
        .scte_35_without_segmentation = "SCTE_35_WITHOUT_SEGMENTATION",
        .scte_35_without_idr = "SCTE_35_WITHOUT_IDR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .scte_35_without_segmentation => "SCTE_35_WITHOUT_SEGMENTATION",
            .scte_35_without_idr => "SCTE_35_WITHOUT_IDR",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
