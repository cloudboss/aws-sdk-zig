const std = @import("std");

/// Hls Ts File Mode
pub const HlsTsFileMode = enum {
    segmented_files,
    single_file,

    pub const json_field_names = .{
        .segmented_files = "SEGMENTED_FILES",
        .single_file = "SINGLE_FILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .segmented_files => "SEGMENTED_FILES",
            .single_file => "SINGLE_FILE",
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
