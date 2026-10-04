const std = @import("std");

/// The compression format that Amazon Web Services uses for the report.
pub const CompressionFormat = enum {
    zip,
    gzip,
    parquet,

    pub const json_field_names = .{
        .zip = "ZIP",
        .gzip = "GZIP",
        .parquet = "Parquet",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zip => "ZIP",
            .gzip => "GZIP",
            .parquet => "Parquet",
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
