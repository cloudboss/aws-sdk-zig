pub const AttachmentStatus = enum {
    attaching,
    attached,
    detaching,
    detached,

    pub const json_field_names = .{
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .detaching = "DETACHING",
        .detached = "DETACHED",
    };
};
