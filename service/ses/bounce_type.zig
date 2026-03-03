const std = @import("std");

pub const BounceType = enum {
    does_not_exist,
    message_too_large,
    exceeded_quota,
    content_rejected,
    @"undefined",
    temporary_failure,

    pub const json_field_names = .{
        .does_not_exist = "DoesNotExist",
        .message_too_large = "MessageTooLarge",
        .exceeded_quota = "ExceededQuota",
        .content_rejected = "ContentRejected",
        .@"undefined" = "Undefined",
        .temporary_failure = "TemporaryFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .does_not_exist => "DoesNotExist",
            .message_too_large => "MessageTooLarge",
            .exceeded_quota => "ExceededQuota",
            .content_rejected => "ContentRejected",
            .@"undefined" => "Undefined",
            .temporary_failure => "TemporaryFailure",
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
