const std = @import("std");

pub const AdditionalS3DataSourceDataType = enum {
    s3_object,
    s3_prefix,

    pub const json_field_names = .{
        .s3_object = "S3Object",
        .s3_prefix = "S3Prefix",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_object => "S3Object",
            .s3_prefix => "S3Prefix",
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
