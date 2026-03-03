const std = @import("std");

/// Dataset Kind
pub const DatasetKind = enum {
    tabular,
    non_tabular,

    pub const json_field_names = .{
        .tabular = "TABULAR",
        .non_tabular = "NON_TABULAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tabular => "TABULAR",
            .non_tabular => "NON_TABULAR",
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
