const std = @import("std");

/// Corresponds to the archive_allowed parameter. A value of ARCHIVE_NOT_ALLOWED
/// corresponds to 0 (false) in the SCTE-35 specification. If you include one of
/// the "restriction" flags then you must include all four of them.
pub const Scte35ArchiveAllowedFlag = enum {
    archive_not_allowed,
    archive_allowed,

    pub const json_field_names = .{
        .archive_not_allowed = "ARCHIVE_NOT_ALLOWED",
        .archive_allowed = "ARCHIVE_ALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .archive_not_allowed => "ARCHIVE_NOT_ALLOWED",
            .archive_allowed => "ARCHIVE_ALLOWED",
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
