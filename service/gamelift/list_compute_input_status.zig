pub const ListComputeInputStatus = enum {
    active,
    impaired,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .impaired = "IMPAIRED",
    };
};
