pub const VendorGuidance = enum {
    active,
    discontinued,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .discontinued = "DISCONTINUED",
        .deleted = "DELETED",
    };
};
