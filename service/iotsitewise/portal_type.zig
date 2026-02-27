pub const PortalType = enum {
    sitewise_portal_v1,
    sitewise_portal_v2,

    pub const json_field_names = .{
        .sitewise_portal_v1 = "SITEWISE_PORTAL_V1",
        .sitewise_portal_v2 = "SITEWISE_PORTAL_V2",
    };
};
