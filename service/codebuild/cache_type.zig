const std = @import("std");

pub const CacheType = enum {
    no_cache,
    s3,
    local,

    pub const json_field_names = .{
        .no_cache = "NO_CACHE",
        .s3 = "S3",
        .local = "LOCAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_cache => "NO_CACHE",
            .s3 => "S3",
            .local => "LOCAL",
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
