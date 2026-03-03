const std = @import("std");

pub const ObjectCannedACL = enum {
    private,
    public_read,
    public_read_write,
    authenticated_read,
    aws_exec_read,
    bucket_owner_read,
    bucket_owner_full_control,

    pub const json_field_names = .{
        .private = "private",
        .public_read = "public-read",
        .public_read_write = "public-read-write",
        .authenticated_read = "authenticated-read",
        .aws_exec_read = "aws-exec-read",
        .bucket_owner_read = "bucket-owner-read",
        .bucket_owner_full_control = "bucket-owner-full-control",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private => "private",
            .public_read => "public-read",
            .public_read_write => "public-read-write",
            .authenticated_read => "authenticated-read",
            .aws_exec_read => "aws-exec-read",
            .bucket_owner_read => "bucket-owner-read",
            .bucket_owner_full_control => "bucket-owner-full-control",
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
