const std = @import("std");

pub const OutputFormat = enum {
    csv,
    json,
    parquet,
    glueparquet,
    avro,
    orc,
    xml,
    tableauhyper,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
        .parquet = "PARQUET",
        .glueparquet = "GLUEPARQUET",
        .avro = "AVRO",
        .orc = "ORC",
        .xml = "XML",
        .tableauhyper = "TABLEAUHYPER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csv => "CSV",
            .json => "JSON",
            .parquet => "PARQUET",
            .glueparquet => "GLUEPARQUET",
            .avro => "AVRO",
            .orc => "ORC",
            .xml => "XML",
            .tableauhyper => "TABLEAUHYPER",
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
