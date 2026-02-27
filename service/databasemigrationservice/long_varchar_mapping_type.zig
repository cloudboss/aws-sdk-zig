pub const LongVarcharMappingType = enum {
    wstring,
    clob,
    nclob,

    pub const json_field_names = .{
        .wstring = "WSTRING",
        .clob = "CLOB",
        .nclob = "NCLOB",
    };
};
