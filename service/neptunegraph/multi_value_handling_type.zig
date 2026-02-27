pub const MultiValueHandlingType = enum {
    to_list,
    pick_first,

    pub const json_field_names = .{
        .to_list = "TO_LIST",
        .pick_first = "PICK_FIRST",
    };
};
