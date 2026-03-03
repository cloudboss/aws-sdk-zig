const std = @import("std");

pub const ErrorCode = enum {
    bad_request,
    conflict,
    forbidden,
    not_found,
    precondition_failed,
    resource_limit_exceeded,
    service_failure,
    access_denied,
    service_unavailable,
    throttled,
    throttling,
    unauthorized,
    unprocessable,
    voice_connector_group_associations_exist,
    phone_number_associations_exist,

    pub const json_field_names = .{
        .bad_request = "BadRequest",
        .conflict = "Conflict",
        .forbidden = "Forbidden",
        .not_found = "NotFound",
        .precondition_failed = "PreconditionFailed",
        .resource_limit_exceeded = "ResourceLimitExceeded",
        .service_failure = "ServiceFailure",
        .access_denied = "AccessDenied",
        .service_unavailable = "ServiceUnavailable",
        .throttled = "Throttled",
        .throttling = "Throttling",
        .unauthorized = "Unauthorized",
        .unprocessable = "Unprocessable",
        .voice_connector_group_associations_exist = "VoiceConnectorGroupAssociationsExist",
        .phone_number_associations_exist = "PhoneNumberAssociationsExist",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bad_request => "BadRequest",
            .conflict => "Conflict",
            .forbidden => "Forbidden",
            .not_found => "NotFound",
            .precondition_failed => "PreconditionFailed",
            .resource_limit_exceeded => "ResourceLimitExceeded",
            .service_failure => "ServiceFailure",
            .access_denied => "AccessDenied",
            .service_unavailable => "ServiceUnavailable",
            .throttled => "Throttled",
            .throttling => "Throttling",
            .unauthorized => "Unauthorized",
            .unprocessable => "Unprocessable",
            .voice_connector_group_associations_exist => "VoiceConnectorGroupAssociationsExist",
            .phone_number_associations_exist => "PhoneNumberAssociationsExist",
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
