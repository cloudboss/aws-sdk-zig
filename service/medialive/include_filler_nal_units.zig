/// Include Filler Nal Units
pub const IncludeFillerNalUnits = enum {
    auto,
    drop,
    include,

    pub const json_field_names = .{
        .auto = "AUTO",
        .drop = "DROP",
        .include = "INCLUDE",
    };
};
