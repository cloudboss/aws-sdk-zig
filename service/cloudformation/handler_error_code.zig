const std = @import("std");

pub const HandlerErrorCode = enum {
    not_updatable,
    invalid_request,
    access_denied,
    invalid_credentials,
    already_exists,
    not_found,
    resource_conflict,
    throttling,
    service_limit_exceeded,
    service_timeout,
    general_service_exception,
    service_internal_error,
    network_failure,
    internal_failure,
    invalid_type_configuration,
    handler_internal_failure,
    non_compliant,
    unknown,
    unsupported_target,

    pub const json_field_names = .{
        .not_updatable = "NotUpdatable",
        .invalid_request = "InvalidRequest",
        .access_denied = "AccessDenied",
        .invalid_credentials = "InvalidCredentials",
        .already_exists = "AlreadyExists",
        .not_found = "NotFound",
        .resource_conflict = "ResourceConflict",
        .throttling = "Throttling",
        .service_limit_exceeded = "ServiceLimitExceeded",
        .service_timeout = "NotStabilized",
        .general_service_exception = "GeneralServiceException",
        .service_internal_error = "ServiceInternalError",
        .network_failure = "NetworkFailure",
        .internal_failure = "InternalFailure",
        .invalid_type_configuration = "InvalidTypeConfiguration",
        .handler_internal_failure = "HandlerInternalFailure",
        .non_compliant = "NonCompliant",
        .unknown = "Unknown",
        .unsupported_target = "UnsupportedTarget",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_updatable => "NotUpdatable",
            .invalid_request => "InvalidRequest",
            .access_denied => "AccessDenied",
            .invalid_credentials => "InvalidCredentials",
            .already_exists => "AlreadyExists",
            .not_found => "NotFound",
            .resource_conflict => "ResourceConflict",
            .throttling => "Throttling",
            .service_limit_exceeded => "ServiceLimitExceeded",
            .service_timeout => "NotStabilized",
            .general_service_exception => "GeneralServiceException",
            .service_internal_error => "ServiceInternalError",
            .network_failure => "NetworkFailure",
            .internal_failure => "InternalFailure",
            .invalid_type_configuration => "InvalidTypeConfiguration",
            .handler_internal_failure => "HandlerInternalFailure",
            .non_compliant => "NonCompliant",
            .unknown => "Unknown",
            .unsupported_target => "UnsupportedTarget",
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
