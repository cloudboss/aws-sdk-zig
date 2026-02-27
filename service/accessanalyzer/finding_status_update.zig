pub const FindingStatusUpdate = enum {
    active,
    archived,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
    };
};
