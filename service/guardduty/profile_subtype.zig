pub const ProfileSubtype = enum {
    frequent,
    infrequent,
    unseen,
    rare,

    pub const json_field_names = .{
        .frequent = "FREQUENT",
        .infrequent = "INFREQUENT",
        .unseen = "UNSEEN",
        .rare = "RARE",
    };
};
