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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
