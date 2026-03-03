const std = @import("std");

pub const FailedItemErrorCode = enum {
    invalid_arn,
    duplicate_arn,
    item_does_not_exist,
    access_denied,
    limit_exceeded,
    internal_error,

    pub const json_field_names = .{
        .invalid_arn = "INVALID_ARN",
        .duplicate_arn = "DUPLICATE_ARN",
        .item_does_not_exist = "ITEM_DOES_NOT_EXIST",
        .access_denied = "ACCESS_DENIED",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_arn => "INVALID_ARN",
            .duplicate_arn => "DUPLICATE_ARN",
            .item_does_not_exist => "ITEM_DOES_NOT_EXIST",
            .access_denied => "ACCESS_DENIED",
            .limit_exceeded => "LIMIT_EXCEEDED",
            .internal_error => "INTERNAL_ERROR",
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
