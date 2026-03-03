const std = @import("std");

/// Hls Directory Structure
pub const HlsDirectoryStructure = enum {
    single_directory,
    subdirectory_per_stream,

    pub const json_field_names = .{
        .single_directory = "SINGLE_DIRECTORY",
        .subdirectory_per_stream = "SUBDIRECTORY_PER_STREAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_directory => "SINGLE_DIRECTORY",
            .subdirectory_per_stream => "SUBDIRECTORY_PER_STREAM",
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
