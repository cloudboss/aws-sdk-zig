const std = @import("std");

pub const BucketMetricName = enum {
    bucket_size_bytes,
    number_of_objects,

    pub const json_field_names = .{
        .bucket_size_bytes = "BucketSizeBytes",
        .number_of_objects = "NumberOfObjects",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bucket_size_bytes => "BucketSizeBytes",
            .number_of_objects => "NumberOfObjects",
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
