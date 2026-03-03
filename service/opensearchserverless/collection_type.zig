const std = @import("std");

pub const CollectionType = enum {
    /// Search collection type
    search,
    /// Timeseries collection type
    timeseries,
    /// Vectorsearch collection type
    vectorsearch,

    pub const json_field_names = .{
        .search = "SEARCH",
        .timeseries = "TIMESERIES",
        .vectorsearch = "VECTORSEARCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .search => "SEARCH",
            .timeseries => "TIMESERIES",
            .vectorsearch => "VECTORSEARCH",
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
