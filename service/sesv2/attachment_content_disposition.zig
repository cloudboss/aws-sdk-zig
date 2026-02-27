pub const AttachmentContentDisposition = enum {
    attachment,
    @"inline",

    pub const json_field_names = .{
        .attachment = "ATTACHMENT",
        .@"inline" = "INLINE",
    };
};
