pub const LifecyclePolicyDetailActionType = enum {
    delete,
    deprecate,
    disable,

    pub const json_field_names = .{
        .delete = "DELETE",
        .deprecate = "DEPRECATE",
        .disable = "DISABLE",
    };
};
