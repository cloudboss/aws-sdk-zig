pub const OperationTargetType = enum {
    namespace,
    service,
    instance,

    pub const json_field_names = .{
        .namespace = "NAMESPACE",
        .service = "SERVICE",
        .instance = "INSTANCE",
    };
};
