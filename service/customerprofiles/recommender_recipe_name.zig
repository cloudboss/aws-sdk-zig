const std = @import("std");

pub const RecommenderRecipeName = enum {
    recommended_for_you,
    similar_items,
    frequently_paired_items,
    popular_items,
    trending_now,

    pub const json_field_names = .{
        .recommended_for_you = "recommended-for-you",
        .similar_items = "similar-items",
        .frequently_paired_items = "frequently-paired-items",
        .popular_items = "popular-items",
        .trending_now = "trending-now",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .recommended_for_you => "recommended-for-you",
            .similar_items => "similar-items",
            .frequently_paired_items => "frequently-paired-items",
            .popular_items => "popular-items",
            .trending_now => "trending-now",
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
