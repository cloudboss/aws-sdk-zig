pub const OutputFormat = enum {
    json,
    cbor,

    pub const json_field_names = .{
        .json = "JSON",
        .cbor = "CBOR",
    };
};
