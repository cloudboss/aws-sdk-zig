const std = @import("std");

pub const DataTableLockLevel = enum {
    none,
    data_table,
    primary_value,
    attribute,
    value,

    pub const json_field_names = .{
        .none = "NONE",
        .data_table = "DATA_TABLE",
        .primary_value = "PRIMARY_VALUE",
        .attribute = "ATTRIBUTE",
        .value = "VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .data_table => "DATA_TABLE",
            .primary_value => "PRIMARY_VALUE",
            .attribute => "ATTRIBUTE",
            .value => "VALUE",
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
