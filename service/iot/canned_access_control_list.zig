const std = @import("std");

pub const CannedAccessControlList = enum {
    private,
    public_read,
    public_read_write,
    aws_exec_read,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,
    log_delivery_write,

    pub const json_field_names = .{
        .private = "private",
        .public_read = "public-read",
        .public_read_write = "public-read-write",
        .aws_exec_read = "aws-exec-read",
        .authenticated_read = "authenticated-read",
        .bucket_owner_read = "bucket-owner-read",
        .bucket_owner_full_control = "bucket-owner-full-control",
        .log_delivery_write = "log-delivery-write",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private => "private",
            .public_read => "public-read",
            .public_read_write => "public-read-write",
            .aws_exec_read => "aws-exec-read",
            .authenticated_read => "authenticated-read",
            .bucket_owner_read => "bucket-owner-read",
            .bucket_owner_full_control => "bucket-owner-full-control",
            .log_delivery_write => "log-delivery-write",
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
