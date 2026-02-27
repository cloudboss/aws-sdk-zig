pub const OperationType = enum {
    create_namespace,
    delete_namespace,
    update_namespace,
    update_service,
    register_instance,
    deregister_instance,

    pub const json_field_names = .{
        .create_namespace = "CREATE_NAMESPACE",
        .delete_namespace = "DELETE_NAMESPACE",
        .update_namespace = "UPDATE_NAMESPACE",
        .update_service = "UPDATE_SERVICE",
        .register_instance = "REGISTER_INSTANCE",
        .deregister_instance = "DEREGISTER_INSTANCE",
    };
};
