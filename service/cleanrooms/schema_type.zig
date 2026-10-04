const std = @import("std");

pub const SchemaType = enum {
    table,
    id_mapping_table,
    intermediate_table,

    pub const json_field_names = .{
        .table = "TABLE",
        .id_mapping_table = "ID_MAPPING_TABLE",
        .intermediate_table = "INTERMEDIATE_TABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .table => "TABLE",
            .id_mapping_table => "ID_MAPPING_TABLE",
            .intermediate_table => "INTERMEDIATE_TABLE",
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
