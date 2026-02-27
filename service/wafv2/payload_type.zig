pub const PayloadType = enum {
    json,
    form_encoded,

    pub const json_field_names = .{
        .json = "JSON",
        .form_encoded = "FORM_ENCODED",
    };
};
