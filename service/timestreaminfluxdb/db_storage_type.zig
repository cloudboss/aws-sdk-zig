pub const DbStorageType = enum {
    influx_io_included_t1,
    influx_io_included_t2,
    influx_io_included_t3,

    pub const json_field_names = .{
        .influx_io_included_t1 = "INFLUX_IO_INCLUDED_T1",
        .influx_io_included_t2 = "INFLUX_IO_INCLUDED_T2",
        .influx_io_included_t3 = "INFLUX_IO_INCLUDED_T3",
    };
};
