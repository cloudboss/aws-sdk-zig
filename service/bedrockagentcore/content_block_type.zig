pub const ContentBlockType = enum {
    text,
    image,
    embedded_resource,
    resource_link,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
        .embedded_resource = "EMBEDDED_RESOURCE",
        .resource_link = "RESOURCE_LINK",
    };
};
