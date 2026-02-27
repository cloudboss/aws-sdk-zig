pub const ApplicationAssociatedResourceType = enum {
    workspace,
    bundle,
    image,

    pub const json_field_names = .{
        .workspace = "WORKSPACE",
        .bundle = "BUNDLE",
        .image = "IMAGE",
    };
};
