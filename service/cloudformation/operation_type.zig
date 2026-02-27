pub const OperationType = enum {
    create_stack,
    update_stack,
    delete_stack,
    continue_rollback,
    rollback,
    create_changeset,
};
