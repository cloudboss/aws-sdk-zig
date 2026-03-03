const std = @import("std");

pub const NullFilterType = enum {
    all_values,
    non_nulls_only,
    nulls_only,

    pub const json_field_names = .{
        .all_values = "ALL_VALUES",
        .non_nulls_only = "NON_NULLS_ONLY",
        .nulls_only = "NULLS_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_values => "ALL_VALUES",
            .non_nulls_only => "NON_NULLS_ONLY",
            .nulls_only => "NULLS_ONLY",
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
