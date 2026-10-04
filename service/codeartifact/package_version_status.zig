const std = @import("std");

pub const PackageVersionStatus = enum {
    published,
    unfinished,
    unlisted,
    archived,
    disposed,
    deleted,

    pub const json_field_names = .{
        .published = "Published",
        .unfinished = "Unfinished",
        .unlisted = "Unlisted",
        .archived = "Archived",
        .disposed = "Disposed",
        .deleted = "Deleted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .published => "Published",
            .unfinished => "Unfinished",
            .unlisted => "Unlisted",
            .archived => "Archived",
            .disposed => "Disposed",
            .deleted => "Deleted",
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
