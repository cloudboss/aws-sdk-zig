pub const OperationFilterName = enum {
    namespace_id,
    service_id,
    status,
    type,
    update_date,

    pub const json_field_names = .{
        .namespace_id = "NAMESPACE_ID",
        .service_id = "SERVICE_ID",
        .status = "STATUS",
        .type = "TYPE",
        .update_date = "UPDATE_DATE",
    };
};
