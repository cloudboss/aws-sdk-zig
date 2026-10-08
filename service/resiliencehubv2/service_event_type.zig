const std = @import("std");

pub const ServiceEventType = enum {
    service_created,
    service_deleted,
    service_system_associated,
    service_system_disassociated,
    service_resources_associated,
    service_resources_disassociated,
    service_workflow_updated,
    service_input_sources_updated,
    service_policy_associated,
    service_policy_disassociated,
    service_function_created,
    service_function_updated,
    service_function_deleted,
    service_function_resources_added,
    service_function_resources_removed,
    service_achievability_updated,
    assertion_created,
    assertion_updated,
    assertion_deleted,

    pub const json_field_names = .{
        .service_created = "SERVICE_CREATED",
        .service_deleted = "SERVICE_DELETED",
        .service_system_associated = "SERVICE_SYSTEM_ASSOCIATED",
        .service_system_disassociated = "SERVICE_SYSTEM_DISASSOCIATED",
        .service_resources_associated = "SERVICE_RESOURCES_ASSOCIATED",
        .service_resources_disassociated = "SERVICE_RESOURCES_DISASSOCIATED",
        .service_workflow_updated = "SERVICE_WORKFLOW_UPDATED",
        .service_input_sources_updated = "SERVICE_INPUT_SOURCES_UPDATED",
        .service_policy_associated = "SERVICE_POLICY_ASSOCIATED",
        .service_policy_disassociated = "SERVICE_POLICY_DISASSOCIATED",
        .service_function_created = "SERVICE_FUNCTION_CREATED",
        .service_function_updated = "SERVICE_FUNCTION_UPDATED",
        .service_function_deleted = "SERVICE_FUNCTION_DELETED",
        .service_function_resources_added = "SERVICE_FUNCTION_RESOURCES_ADDED",
        .service_function_resources_removed = "SERVICE_FUNCTION_RESOURCES_REMOVED",
        .service_achievability_updated = "SERVICE_ACHIEVABILITY_UPDATED",
        .assertion_created = "ASSERTION_CREATED",
        .assertion_updated = "ASSERTION_UPDATED",
        .assertion_deleted = "ASSERTION_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_created => "SERVICE_CREATED",
            .service_deleted => "SERVICE_DELETED",
            .service_system_associated => "SERVICE_SYSTEM_ASSOCIATED",
            .service_system_disassociated => "SERVICE_SYSTEM_DISASSOCIATED",
            .service_resources_associated => "SERVICE_RESOURCES_ASSOCIATED",
            .service_resources_disassociated => "SERVICE_RESOURCES_DISASSOCIATED",
            .service_workflow_updated => "SERVICE_WORKFLOW_UPDATED",
            .service_input_sources_updated => "SERVICE_INPUT_SOURCES_UPDATED",
            .service_policy_associated => "SERVICE_POLICY_ASSOCIATED",
            .service_policy_disassociated => "SERVICE_POLICY_DISASSOCIATED",
            .service_function_created => "SERVICE_FUNCTION_CREATED",
            .service_function_updated => "SERVICE_FUNCTION_UPDATED",
            .service_function_deleted => "SERVICE_FUNCTION_DELETED",
            .service_function_resources_added => "SERVICE_FUNCTION_RESOURCES_ADDED",
            .service_function_resources_removed => "SERVICE_FUNCTION_RESOURCES_REMOVED",
            .service_achievability_updated => "SERVICE_ACHIEVABILITY_UPDATED",
            .assertion_created => "ASSERTION_CREATED",
            .assertion_updated => "ASSERTION_UPDATED",
            .assertion_deleted => "ASSERTION_DELETED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
