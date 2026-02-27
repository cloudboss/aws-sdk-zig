pub const SheetLayoutGroupMemberType = enum {
    element,
    group,

    pub const json_field_names = .{
        .element = "ELEMENT",
        .group = "GROUP",
    };
};
