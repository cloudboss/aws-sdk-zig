const std = @import("std");

/// The data storage format for Athena query results.
pub const AthenaResultFormat = enum {
    parquet,
    orc,
    avro,
    json,
    textfile,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .orc = "ORC",
        .avro = "AVRO",
        .json = "JSON",
        .textfile = "TEXTFILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .parquet => "PARQUET",
            .orc => "ORC",
            .avro => "AVRO",
            .json => "JSON",
            .textfile => "TEXTFILE",
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
