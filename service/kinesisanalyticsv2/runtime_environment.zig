const std = @import("std");

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
        .sql_1_0 = "SQL-1_0",
        .flink_1_6 = "FLINK-1_6",
        .flink_1_8 = "FLINK-1_8",
        .zeppelin_flink_1_0 = "ZEPPELIN-FLINK-1_0",
        .flink_1_11 = "FLINK-1_11",
        .flink_1_13 = "FLINK-1_13",
        .zeppelin_flink_2_0 = "ZEPPELIN-FLINK-2_0",
        .flink_1_15 = "FLINK-1_15",
        .zeppelin_flink_3_0 = "ZEPPELIN-FLINK-3_0",
        .flink_1_18 = "FLINK-1_18",
        .flink_1_19 = "FLINK-1_19",
        .flink_1_20 = "FLINK-1_20",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sql_1_0 => "SQL-1_0",
            .flink_1_6 => "FLINK-1_6",
            .flink_1_8 => "FLINK-1_8",
            .zeppelin_flink_1_0 => "ZEPPELIN-FLINK-1_0",
            .flink_1_11 => "FLINK-1_11",
            .flink_1_13 => "FLINK-1_13",
            .zeppelin_flink_2_0 => "ZEPPELIN-FLINK-2_0",
            .flink_1_15 => "FLINK-1_15",
            .zeppelin_flink_3_0 => "ZEPPELIN-FLINK-3_0",
            .flink_1_18 => "FLINK-1_18",
            .flink_1_19 => "FLINK-1_19",
            .flink_1_20 => "FLINK-1_20",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
