const std = @import("std");

pub const RankingStatisticType = enum {
    top_sources_by_revenue,
    top_paths_by_revenue,

    pub const json_field_names = .{
        .top_sources_by_revenue = "TOP_SOURCES_BY_REVENUE",
        .top_paths_by_revenue = "TOP_PATHS_BY_REVENUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .top_sources_by_revenue => "TOP_SOURCES_BY_REVENUE",
            .top_paths_by_revenue => "TOP_PATHS_BY_REVENUE",
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
