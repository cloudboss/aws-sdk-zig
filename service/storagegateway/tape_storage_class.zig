const std = @import("std");

pub const TapeStorageClass = enum {
    deep_archive,
    glacier,

    pub const json_field_names = .{
        .deep_archive = "DEEP_ARCHIVE",
        .glacier = "GLACIER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deep_archive => "DEEP_ARCHIVE",
            .glacier => "GLACIER",
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
