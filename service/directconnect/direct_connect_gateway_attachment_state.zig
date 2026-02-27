pub const DirectConnectGatewayAttachmentState = enum {
    attaching,
    attached,
    detaching,
    detached,

    pub const json_field_names = .{
        .attaching = "attaching",
        .attached = "attached",
        .detaching = "detaching",
        .detached = "detached",
    };
};
