pub const CsvSerdeOption = enum {
    open_csv_ser_de,
    lazy_simple_ser_de,
    none,

    pub const json_field_names = .{
        .open_csv_ser_de = "OpenCSVSerDe",
        .lazy_simple_ser_de = "LazySimpleSerDe",
        .none = "None",
    };
};
