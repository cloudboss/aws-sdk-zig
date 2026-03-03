const std = @import("std");

/// A value that sets the access control list (ACL) permission for objects in
/// the S3 bucket
/// that an S3 File Gateway puts objects into. The default value is
/// `private`.
pub const ObjectACL = enum {
    private,
    public_read,
    public_read_write,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,
    aws_exec_read,

    pub const json_field_names = .{
        .private = "private",
        .public_read = "public-read",
        .public_read_write = "public-read-write",
        .authenticated_read = "authenticated-read",
        .bucket_owner_read = "bucket-owner-read",
        .bucket_owner_full_control = "bucket-owner-full-control",
        .aws_exec_read = "aws-exec-read",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private => "private",
            .public_read => "public-read",
            .public_read_write => "public-read-write",
            .authenticated_read => "authenticated-read",
            .bucket_owner_read => "bucket-owner-read",
            .bucket_owner_full_control => "bucket-owner-full-control",
            .aws_exec_read => "aws-exec-read",
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
