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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
