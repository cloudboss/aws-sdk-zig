const std = @import("std");

/// Publish synchronization state of the DRAFT working copy.
pub const DraftStatus = enum {
    /// DRAFT has changes not yet reflected in any published version, or no versions
    /// have been published yet.
    modified,
    /// DRAFT content matches the latest published version exactly.
    unmodified,

    pub const json_field_names = .{
        .modified = "MODIFIED",
        .unmodified = "UNMODIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .modified => "MODIFIED",
            .unmodified => "UNMODIFIED",
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
