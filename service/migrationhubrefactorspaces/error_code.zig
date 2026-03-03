const std = @import("std");

pub const ErrorCode = enum {
    invalid_resource_state,
    resource_limit_exceeded,
    resource_creation_failure,
    resource_update_failure,
    service_endpoint_health_check_failure,
    resource_deletion_failure,
    resource_retrieval_failure,
    resource_in_use,
    resource_not_found,
    state_transition_failure,
    request_limit_exceeded,
    not_authorized,

    pub const json_field_names = .{
        .invalid_resource_state = "INVALID_RESOURCE_STATE",
        .resource_limit_exceeded = "RESOURCE_LIMIT_EXCEEDED",
        .resource_creation_failure = "RESOURCE_CREATION_FAILURE",
        .resource_update_failure = "RESOURCE_UPDATE_FAILURE",
        .service_endpoint_health_check_failure = "SERVICE_ENDPOINT_HEALTH_CHECK_FAILURE",
        .resource_deletion_failure = "RESOURCE_DELETION_FAILURE",
        .resource_retrieval_failure = "RESOURCE_RETRIEVAL_FAILURE",
        .resource_in_use = "RESOURCE_IN_USE",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .state_transition_failure = "STATE_TRANSITION_FAILURE",
        .request_limit_exceeded = "REQUEST_LIMIT_EXCEEDED",
        .not_authorized = "NOT_AUTHORIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_resource_state => "INVALID_RESOURCE_STATE",
            .resource_limit_exceeded => "RESOURCE_LIMIT_EXCEEDED",
            .resource_creation_failure => "RESOURCE_CREATION_FAILURE",
            .resource_update_failure => "RESOURCE_UPDATE_FAILURE",
            .service_endpoint_health_check_failure => "SERVICE_ENDPOINT_HEALTH_CHECK_FAILURE",
            .resource_deletion_failure => "RESOURCE_DELETION_FAILURE",
            .resource_retrieval_failure => "RESOURCE_RETRIEVAL_FAILURE",
            .resource_in_use => "RESOURCE_IN_USE",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .state_transition_failure => "STATE_TRANSITION_FAILURE",
            .request_limit_exceeded => "REQUEST_LIMIT_EXCEEDED",
            .not_authorized => "NOT_AUTHORIZED",
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
