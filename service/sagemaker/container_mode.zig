pub const ContainerMode = enum {
    single_model,
    multi_model,

    pub const json_field_names = .{
        .single_model = "SINGLE_MODEL",
        .multi_model = "MULTI_MODEL",
    };
};
