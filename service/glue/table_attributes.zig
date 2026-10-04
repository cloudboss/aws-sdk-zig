const std = @import("std");

pub const TableAttributes = enum {
    name,
    table_type,
    default,
    latest_iceberg_metadata,

    pub const json_field_names = .{
        .name = "NAME",
        .table_type = "TABLE_TYPE",
        .default = "DEFAULT",
        .latest_iceberg_metadata = "LATEST_ICEBERG_METADATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .table_type => "TABLE_TYPE",
            .default => "DEFAULT",
            .latest_iceberg_metadata => "LATEST_ICEBERG_METADATA",
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
