const std = @import("std");

/// Storage tier for image sets
pub const StorageTier = enum {
    /// Frequent access storage tier for image sets that are accessed regularly
    frequent_access,
    /// Archive instant access storage tier for image sets that are accessed
    /// infrequently
    archive_instant_access,

    pub const json_field_names = .{
        .frequent_access = "FREQUENT_ACCESS",
        .archive_instant_access = "ARCHIVE_INSTANT_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .frequent_access => "FREQUENT_ACCESS",
            .archive_instant_access => "ARCHIVE_INSTANT_ACCESS",
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
