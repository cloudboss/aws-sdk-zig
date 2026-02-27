/// H265 Alternative Transfer Function
pub const H265AlternativeTransferFunction = enum {
    insert,
    omit,

    pub const json_field_names = .{
        .insert = "INSERT",
        .omit = "OMIT",
    };
};
