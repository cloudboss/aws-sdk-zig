pub const PolicyType = enum {
    static,
    template_linked,

    pub const json_field_names = .{
        .static = "STATIC",
        .template_linked = "TEMPLATE_LINKED",
    };
};
