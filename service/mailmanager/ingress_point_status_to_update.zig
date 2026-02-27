pub const IngressPointStatusToUpdate = enum {
    active,
    closed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .closed = "CLOSED",
    };
};
