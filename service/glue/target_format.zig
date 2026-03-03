const std = @import("std");

pub const TargetFormat = enum {
    json,
    csv,
    avro,
    orc,
    parquet,
    hudi,
    delta,
    iceberg,
    hyper,
    xml,

    pub const json_field_names = .{
        .json = "json",
        .csv = "csv",
        .avro = "avro",
        .orc = "orc",
        .parquet = "parquet",
        .hudi = "hudi",
        .delta = "delta",
        .iceberg = "iceberg",
        .hyper = "hyper",
        .xml = "xml",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json => "json",
            .csv => "csv",
            .avro => "avro",
            .orc => "orc",
            .parquet => "parquet",
            .hudi => "hudi",
            .delta => "delta",
            .iceberg => "iceberg",
            .hyper => "hyper",
            .xml => "xml",
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
