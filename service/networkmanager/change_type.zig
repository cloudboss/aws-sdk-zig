const std = @import("std");

pub const ChangeType = enum {
    core_network_segment,
    network_function_group,
    core_network_edge,
    attachment_mapping,
    attachment_route_propagation,
    attachment_route_static,
    routing_policy,
    routing_policy_segment_association,
    routing_policy_edge_association,
    routing_policy_attachment_association,
    core_network_configuration,
    segments_configuration,
    segment_actions_configuration,
    attachment_policies_configuration,

    pub const json_field_names = .{
        .core_network_segment = "CORE_NETWORK_SEGMENT",
        .network_function_group = "NETWORK_FUNCTION_GROUP",
        .core_network_edge = "CORE_NETWORK_EDGE",
        .attachment_mapping = "ATTACHMENT_MAPPING",
        .attachment_route_propagation = "ATTACHMENT_ROUTE_PROPAGATION",
        .attachment_route_static = "ATTACHMENT_ROUTE_STATIC",
        .routing_policy = "ROUTING_POLICY",
        .routing_policy_segment_association = "ROUTING_POLICY_SEGMENT_ASSOCIATION",
        .routing_policy_edge_association = "ROUTING_POLICY_EDGE_ASSOCIATION",
        .routing_policy_attachment_association = "ROUTING_POLICY_ATTACHMENT_ASSOCIATION",
        .core_network_configuration = "CORE_NETWORK_CONFIGURATION",
        .segments_configuration = "SEGMENTS_CONFIGURATION",
        .segment_actions_configuration = "SEGMENT_ACTIONS_CONFIGURATION",
        .attachment_policies_configuration = "ATTACHMENT_POLICIES_CONFIGURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .core_network_segment => "CORE_NETWORK_SEGMENT",
            .network_function_group => "NETWORK_FUNCTION_GROUP",
            .core_network_edge => "CORE_NETWORK_EDGE",
            .attachment_mapping => "ATTACHMENT_MAPPING",
            .attachment_route_propagation => "ATTACHMENT_ROUTE_PROPAGATION",
            .attachment_route_static => "ATTACHMENT_ROUTE_STATIC",
            .routing_policy => "ROUTING_POLICY",
            .routing_policy_segment_association => "ROUTING_POLICY_SEGMENT_ASSOCIATION",
            .routing_policy_edge_association => "ROUTING_POLICY_EDGE_ASSOCIATION",
            .routing_policy_attachment_association => "ROUTING_POLICY_ATTACHMENT_ASSOCIATION",
            .core_network_configuration => "CORE_NETWORK_CONFIGURATION",
            .segments_configuration => "SEGMENTS_CONFIGURATION",
            .segment_actions_configuration => "SEGMENT_ACTIONS_CONFIGURATION",
            .attachment_policies_configuration => "ATTACHMENT_POLICIES_CONFIGURATION",
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
