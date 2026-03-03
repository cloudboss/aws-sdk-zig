const std = @import("std");

pub const ParquetVersionValue = enum {
    parquet_1_0,
    parquet_2_0,

    pub const json_field_names = .{
        .parquet_1_0 = "parquet-1-0",
        .parquet_2_0 = "parquet-2-0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .parquet_1_0 => "parquet-1-0",
            .parquet_2_0 => "parquet-2-0",
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
