const std = @import("std");

pub const GatewayResponseType = enum {
    default_4_xx,
    default_5_xx,
    resource_not_found,
    unauthorized,
    invalid_api_key,
    access_denied,
    authorizer_failure,
    authorizer_configuration_error,
    invalid_signature,
    expired_token,
    missing_authentication_token,
    integration_failure,
    integration_timeout,
    api_configuration_error,
    unsupported_media_type,
    bad_request_parameters,
    bad_request_body,
    request_too_large,
    throttled,
    quota_exceeded,
    waf_filtered,

    pub const json_field_names = .{
        .default_4_xx = "DEFAULT_4XX",
        .default_5_xx = "DEFAULT_5XX",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .unauthorized = "UNAUTHORIZED",
        .invalid_api_key = "INVALID_API_KEY",
        .access_denied = "ACCESS_DENIED",
        .authorizer_failure = "AUTHORIZER_FAILURE",
        .authorizer_configuration_error = "AUTHORIZER_CONFIGURATION_ERROR",
        .invalid_signature = "INVALID_SIGNATURE",
        .expired_token = "EXPIRED_TOKEN",
        .missing_authentication_token = "MISSING_AUTHENTICATION_TOKEN",
        .integration_failure = "INTEGRATION_FAILURE",
        .integration_timeout = "INTEGRATION_TIMEOUT",
        .api_configuration_error = "API_CONFIGURATION_ERROR",
        .unsupported_media_type = "UNSUPPORTED_MEDIA_TYPE",
        .bad_request_parameters = "BAD_REQUEST_PARAMETERS",
        .bad_request_body = "BAD_REQUEST_BODY",
        .request_too_large = "REQUEST_TOO_LARGE",
        .throttled = "THROTTLED",
        .quota_exceeded = "QUOTA_EXCEEDED",
        .waf_filtered = "WAF_FILTERED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_4_xx => "DEFAULT_4XX",
            .default_5_xx => "DEFAULT_5XX",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .unauthorized => "UNAUTHORIZED",
            .invalid_api_key => "INVALID_API_KEY",
            .access_denied => "ACCESS_DENIED",
            .authorizer_failure => "AUTHORIZER_FAILURE",
            .authorizer_configuration_error => "AUTHORIZER_CONFIGURATION_ERROR",
            .invalid_signature => "INVALID_SIGNATURE",
            .expired_token => "EXPIRED_TOKEN",
            .missing_authentication_token => "MISSING_AUTHENTICATION_TOKEN",
            .integration_failure => "INTEGRATION_FAILURE",
            .integration_timeout => "INTEGRATION_TIMEOUT",
            .api_configuration_error => "API_CONFIGURATION_ERROR",
            .unsupported_media_type => "UNSUPPORTED_MEDIA_TYPE",
            .bad_request_parameters => "BAD_REQUEST_PARAMETERS",
            .bad_request_body => "BAD_REQUEST_BODY",
            .request_too_large => "REQUEST_TOO_LARGE",
            .throttled => "THROTTLED",
            .quota_exceeded => "QUOTA_EXCEEDED",
            .waf_filtered => "WAF_FILTERED",
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
