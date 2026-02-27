pub const VolumeAttachmentStatus = enum {
    attaching,
    attached,
    detaching,
    detached,
    busy,

    pub const json_field_names = .{
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .detaching = "DETACHING",
        .detached = "DETACHED",
        .busy = "BUSY",
    };
};
