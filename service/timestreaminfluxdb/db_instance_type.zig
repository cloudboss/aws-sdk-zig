pub const DbInstanceType = enum {
    db_influx_medium,
    db_influx_large,
    db_influx_xlarge,
    db_influx_2_xlarge,
    db_influx_4_xlarge,
    db_influx_8_xlarge,
    db_influx_12_xlarge,
    db_influx_16_xlarge,
    db_influx_24_xlarge,

    pub const json_field_names = .{
        .db_influx_medium = "DB_INFLUX_MEDIUM",
        .db_influx_large = "DB_INFLUX_LARGE",
        .db_influx_xlarge = "DB_INFLUX_XLARGE",
        .db_influx_2_xlarge = "DB_INFLUX_2XLARGE",
        .db_influx_4_xlarge = "DB_INFLUX_4XLARGE",
        .db_influx_8_xlarge = "DB_INFLUX_8XLARGE",
        .db_influx_12_xlarge = "DB_INFLUX_12XLARGE",
        .db_influx_16_xlarge = "DB_INFLUX_16XLARGE",
        .db_influx_24_xlarge = "DB_INFLUX_24XLARGE",
    };
};
