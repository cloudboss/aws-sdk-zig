pub const LabelMatchScope = enum {
    label,
    namespace,

    pub const json_field_names = .{
        .label = "LABEL",
        .namespace = "NAMESPACE",
    };
};
