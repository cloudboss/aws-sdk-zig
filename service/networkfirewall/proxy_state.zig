pub const ProxyState = enum {
    attaching,
    attached,
    detaching,
    detached,
    attach_failed,
    detach_failed,

    pub const json_field_names = .{
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .detaching = "DETACHING",
        .detached = "DETACHED",
        .attach_failed = "ATTACH_FAILED",
        .detach_failed = "DETACH_FAILED",
    };
};
