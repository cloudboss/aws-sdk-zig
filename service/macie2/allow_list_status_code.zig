const std = @import("std");

/// Indicates the current status of an allow list. Depending on the type of
/// criteria that the list specifies, possible values are:
pub const AllowListStatusCode = enum {
    ok,
    s3_object_not_found,
    s3_user_access_denied,
    s3_object_access_denied,
    s3_throttled,
    s3_object_oversize,
    s3_object_empty,
    unknown_error,

    pub const json_field_names = .{
        .ok = "OK",
        .s3_object_not_found = "S3_OBJECT_NOT_FOUND",
        .s3_user_access_denied = "S3_USER_ACCESS_DENIED",
        .s3_object_access_denied = "S3_OBJECT_ACCESS_DENIED",
        .s3_throttled = "S3_THROTTLED",
        .s3_object_oversize = "S3_OBJECT_OVERSIZE",
        .s3_object_empty = "S3_OBJECT_EMPTY",
        .unknown_error = "UNKNOWN_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ok => "OK",
            .s3_object_not_found => "S3_OBJECT_NOT_FOUND",
            .s3_user_access_denied => "S3_USER_ACCESS_DENIED",
            .s3_object_access_denied => "S3_OBJECT_ACCESS_DENIED",
            .s3_throttled => "S3_THROTTLED",
            .s3_object_oversize => "S3_OBJECT_OVERSIZE",
            .s3_object_empty => "S3_OBJECT_EMPTY",
            .unknown_error => "UNKNOWN_ERROR",
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
