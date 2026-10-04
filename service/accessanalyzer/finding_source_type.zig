const std = @import("std");

pub const FindingSourceType = enum {
    policy,
    bucket_acl,
    s3_access_point,
    s3_access_point_account,

    pub const json_field_names = .{
        .policy = "POLICY",
        .bucket_acl = "BUCKET_ACL",
        .s3_access_point = "S3_ACCESS_POINT",
        .s3_access_point_account = "S3_ACCESS_POINT_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy => "POLICY",
            .bucket_acl => "BUCKET_ACL",
            .s3_access_point => "S3_ACCESS_POINT",
            .s3_access_point_account => "S3_ACCESS_POINT_ACCOUNT",
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
