pub const OperationType = enum {
    readonly,
    mutation,

    pub const json_field_names = .{
        .readonly = "READONLY",
        .mutation = "MUTATION",
    };
};
