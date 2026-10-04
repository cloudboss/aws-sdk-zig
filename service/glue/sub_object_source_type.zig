const std = @import("std");

pub const SubObjectSourceType = enum {
    hive_parquet,
    hive_orc,
    hive_csv,
    hive_json,
    plain_parquet,
    iceberg,

    pub const json_field_names = .{
        .hive_parquet = "HIVE_PARQUET",
        .hive_orc = "HIVE_ORC",
        .hive_csv = "HIVE_CSV",
        .hive_json = "HIVE_JSON",
        .plain_parquet = "PLAIN_PARQUET",
        .iceberg = "ICEBERG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hive_parquet => "HIVE_PARQUET",
            .hive_orc => "HIVE_ORC",
            .hive_csv => "HIVE_CSV",
            .hive_json => "HIVE_JSON",
            .plain_parquet => "PLAIN_PARQUET",
            .iceberg => "ICEBERG",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
