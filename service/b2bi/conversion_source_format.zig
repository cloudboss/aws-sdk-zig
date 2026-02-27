pub const ConversionSourceFormat = enum {
    json,
    xml,

    pub const json_field_names = .{
        .json = "JSON",
        .xml = "XML",
    };
};
