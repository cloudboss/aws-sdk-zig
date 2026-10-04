const std = @import("std");

/// The strategy used to apply filter predicates to REST API requests.
pub const FilterMode = enum {
    query_params,
    filter_string,

    pub const json_field_names = .{
        .query_params = "QUERY_PARAMS",
        .filter_string = "FILTER_STRING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .query_params => "QUERY_PARAMS",
            .filter_string => "FILTER_STRING",
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
