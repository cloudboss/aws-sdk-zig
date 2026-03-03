const std = @import("std");

pub const HandlerErrorCode = enum {
    not_updatable,
    invalid_request,
    access_denied,
    unauthorized_tagging_operation,
    invalid_credentials,
    already_exists,
    not_found,
    resource_conflict,
    throttling,
    service_limit_exceeded,
    not_stabilized,
    general_service_exception,
    service_internal_error,
    service_timeout,
    network_failure,
    internal_failure,

    pub const json_field_names = .{
        .not_updatable = "NotUpdatable",
        .invalid_request = "InvalidRequest",
        .access_denied = "AccessDenied",
        .unauthorized_tagging_operation = "UnauthorizedTaggingOperation",
        .invalid_credentials = "InvalidCredentials",
        .already_exists = "AlreadyExists",
        .not_found = "NotFound",
        .resource_conflict = "ResourceConflict",
        .throttling = "Throttling",
        .service_limit_exceeded = "ServiceLimitExceeded",
        .not_stabilized = "NotStabilized",
        .general_service_exception = "GeneralServiceException",
        .service_internal_error = "ServiceInternalError",
        .service_timeout = "ServiceTimeout",
        .network_failure = "NetworkFailure",
        .internal_failure = "InternalFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_updatable => "NotUpdatable",
            .invalid_request => "InvalidRequest",
            .access_denied => "AccessDenied",
            .unauthorized_tagging_operation => "UnauthorizedTaggingOperation",
            .invalid_credentials => "InvalidCredentials",
            .already_exists => "AlreadyExists",
            .not_found => "NotFound",
            .resource_conflict => "ResourceConflict",
            .throttling => "Throttling",
            .service_limit_exceeded => "ServiceLimitExceeded",
            .not_stabilized => "NotStabilized",
            .general_service_exception => "GeneralServiceException",
            .service_internal_error => "ServiceInternalError",
            .service_timeout => "ServiceTimeout",
            .network_failure => "NetworkFailure",
            .internal_failure => "InternalFailure",
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
