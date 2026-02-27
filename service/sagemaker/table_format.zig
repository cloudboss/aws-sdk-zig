pub const TableFormat = enum {
    default,
    glue,
    iceberg,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .glue = "GLUE",
        .iceberg = "ICEBERG",
    };
};
