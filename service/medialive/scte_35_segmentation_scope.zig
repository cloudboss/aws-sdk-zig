const std = @import("std");

/// Scte35 Segmentation Scope
pub const Scte35SegmentationScope = enum {
    all_output_groups,
    scte35_enabled_output_groups,

    pub const json_field_names = .{
        .all_output_groups = "ALL_OUTPUT_GROUPS",
        .scte35_enabled_output_groups = "SCTE35_ENABLED_OUTPUT_GROUPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_output_groups => "ALL_OUTPUT_GROUPS",
            .scte35_enabled_output_groups => "SCTE35_ENABLED_OUTPUT_GROUPS",
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
