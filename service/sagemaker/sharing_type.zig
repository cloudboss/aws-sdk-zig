pub const SharingType = enum {
    private,
    shared,

    pub const json_field_names = .{
        .private = "Private",
        .shared = "Shared",
    };
};
