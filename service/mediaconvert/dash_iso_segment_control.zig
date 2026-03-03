const std = @import("std");

/// When set to SINGLE_FILE, a single output file is generated, which is
/// internally segmented using the Fragment Length and Segment Length. When set
/// to SEGMENTED_FILES, separate segment files will be created.
pub const DashIsoSegmentControl = enum {
    single_file,
    segmented_files,

    pub const json_field_names = .{
        .single_file = "SINGLE_FILE",
        .segmented_files = "SEGMENTED_FILES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_file => "SINGLE_FILE",
            .segmented_files => "SEGMENTED_FILES",
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
