const std = @import("std");

pub const AnalysisRuleType = enum {
    aggregation,
    list,
    custom,
    id_mapping_table,

    pub const json_field_names = .{
        .aggregation = "AGGREGATION",
        .list = "LIST",
        .custom = "CUSTOM",
        .id_mapping_table = "ID_MAPPING_TABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aggregation => "AGGREGATION",
            .list => "LIST",
            .custom => "CUSTOM",
            .id_mapping_table => "ID_MAPPING_TABLE",
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
