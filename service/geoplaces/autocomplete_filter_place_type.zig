pub const AutocompleteFilterPlaceType = enum {
    locality,
    postal_code,

    pub const json_field_names = .{
        .locality = "LOCALITY",
        .postal_code = "POSTAL_CODE",
    };
};
