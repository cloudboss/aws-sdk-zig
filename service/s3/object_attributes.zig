const std = @import("std");

pub const ObjectAttributes = enum {
    etag,
    checksum,
    object_parts,
    storage_class,
    object_size,

    pub const json_field_names = .{
        .etag = "ETag",
        .checksum = "Checksum",
        .object_parts = "ObjectParts",
        .storage_class = "StorageClass",
        .object_size = "ObjectSize",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .etag => "ETag",
            .checksum => "Checksum",
            .object_parts => "ObjectParts",
            .storage_class => "StorageClass",
            .object_size => "ObjectSize",
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
