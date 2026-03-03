const std = @import("std");

pub const Format = enum {
    csv,
    open_cypher,
    parquet,
    ntriples,

    pub const json_field_names = .{
        .csv = "CSV",
        .open_cypher = "OPEN_CYPHER",
        .parquet = "PARQUET",
        .ntriples = "NTRIPLES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csv => "CSV",
            .open_cypher => "OPEN_CYPHER",
            .parquet => "PARQUET",
            .ntriples => "NTRIPLES",
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
