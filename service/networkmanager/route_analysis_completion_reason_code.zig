pub const RouteAnalysisCompletionReasonCode = enum {
    transit_gateway_attachment_not_found,
    transit_gateway_attachment_not_in_transit_gateway,
    cyclic_path_detected,
    transit_gateway_attachment_stable_route_table_not_found,
    route_not_found,
    blackhole_route_for_destination_found,
    inactive_route_for_destination_found,
    transit_gateway_attachment,
    max_hops_exceeded,
    possible_middlebox,
    no_destination_arn_provided,

    pub const json_field_names = .{
        .transit_gateway_attachment_not_found = "TRANSIT_GATEWAY_ATTACHMENT_NOT_FOUND",
        .transit_gateway_attachment_not_in_transit_gateway = "TRANSIT_GATEWAY_ATTACHMENT_NOT_IN_TRANSIT_GATEWAY",
        .cyclic_path_detected = "CYCLIC_PATH_DETECTED",
        .transit_gateway_attachment_stable_route_table_not_found = "TRANSIT_GATEWAY_ATTACHMENT_STABLE_ROUTE_TABLE_NOT_FOUND",
        .route_not_found = "ROUTE_NOT_FOUND",
        .blackhole_route_for_destination_found = "BLACKHOLE_ROUTE_FOR_DESTINATION_FOUND",
        .inactive_route_for_destination_found = "INACTIVE_ROUTE_FOR_DESTINATION_FOUND",
        .transit_gateway_attachment = "TRANSIT_GATEWAY_ATTACHMENT",
        .max_hops_exceeded = "MAX_HOPS_EXCEEDED",
        .possible_middlebox = "POSSIBLE_MIDDLEBOX",
        .no_destination_arn_provided = "NO_DESTINATION_ARN_PROVIDED",
    };
};
