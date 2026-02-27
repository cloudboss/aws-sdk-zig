pub const PackageScopeOperationEnum = enum {
    add,
    override,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .override = "OVERRIDE",
        .remove = "REMOVE",
    };
};
