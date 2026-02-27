pub const RuntimeEnvironment = enum {
    sql_1_0,
    flink_1_6,
    flink_1_8,
    zeppelin_flink_1_0,
    flink_1_11,
    flink_1_13,
    zeppelin_flink_2_0,
    flink_1_15,
    zeppelin_flink_3_0,
    flink_1_18,
    flink_1_19,
    flink_1_20,

    pub const json_field_names = .{
        .sql_1_0 = "SQL_1_0",
        .flink_1_6 = "FLINK_1_6",
        .flink_1_8 = "FLINK_1_8",
        .zeppelin_flink_1_0 = "ZEPPELIN_FLINK_1_0",
        .flink_1_11 = "FLINK_1_11",
        .flink_1_13 = "FLINK_1_13",
        .zeppelin_flink_2_0 = "ZEPPELIN_FLINK_2_0",
        .flink_1_15 = "FLINK_1_15",
        .zeppelin_flink_3_0 = "ZEPPELIN_FLINK_3_0",
        .flink_1_18 = "FLINK_1_18",
        .flink_1_19 = "FLINK_1_19",
        .flink_1_20 = "FLINK_1_20",
    };
};
