pub const OwnershipType = enum {
    self,
    shared,

    pub const json_field_names = .{
        .self = "SELF",
        .shared = "SHARED",
    };
};
