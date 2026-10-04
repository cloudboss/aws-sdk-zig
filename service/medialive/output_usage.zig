const std = @import("std");

/// Output Usage
pub const OutputUsage = enum {
    multiview_equal_size_view,
    multiview_primary_view,
    multiview_secondary_view,

    pub const json_field_names = .{
        .multiview_equal_size_view = "MULTIVIEW_EQUAL_SIZE_VIEW",
        .multiview_primary_view = "MULTIVIEW_PRIMARY_VIEW",
        .multiview_secondary_view = "MULTIVIEW_SECONDARY_VIEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multiview_equal_size_view => "MULTIVIEW_EQUAL_SIZE_VIEW",
            .multiview_primary_view => "MULTIVIEW_PRIMARY_VIEW",
            .multiview_secondary_view => "MULTIVIEW_SECONDARY_VIEW",
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
