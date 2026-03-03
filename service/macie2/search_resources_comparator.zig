const std = @import("std");

/// The operator to use in a condition that filters the results of a query.
/// Valid values are:
pub const SearchResourcesComparator = enum {
    eq,
    ne,

    pub const json_field_names = .{
        .eq = "EQ",
        .ne = "NE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "EQ",
            .ne => "NE",
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
