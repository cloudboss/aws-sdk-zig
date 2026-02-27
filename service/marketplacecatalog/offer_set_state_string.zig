pub const OfferSetStateString = enum {
    draft,
    released,

    pub const json_field_names = .{
        .draft = "Draft",
        .released = "Released",
    };
};
