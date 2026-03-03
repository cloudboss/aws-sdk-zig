const std = @import("std");

/// The instance type (such as `search.m1.small`) on which an index partition is
/// hosted.
pub const PartitionInstanceType = enum {
    search_m_1_small,
    search_m_1_large,
    search_m_2_xlarge,
    search_m_2_2_xlarge,
    search_m_3_medium,
    search_m_3_large,
    search_m_3_xlarge,
    search_m_3_2_xlarge,
    search_small,
    search_medium,
    search_large,
    search_xlarge,
    search_2_xlarge,
    search_previousgeneration_small,
    search_previousgeneration_large,
    search_previousgeneration_xlarge,
    search_previousgeneration_2_xlarge,

    pub const json_field_names = .{
        .search_m_1_small = "search.m1.small",
        .search_m_1_large = "search.m1.large",
        .search_m_2_xlarge = "search.m2.xlarge",
        .search_m_2_2_xlarge = "search.m2.2xlarge",
        .search_m_3_medium = "search.m3.medium",
        .search_m_3_large = "search.m3.large",
        .search_m_3_xlarge = "search.m3.xlarge",
        .search_m_3_2_xlarge = "search.m3.2xlarge",
        .search_small = "search.small",
        .search_medium = "search.medium",
        .search_large = "search.large",
        .search_xlarge = "search.xlarge",
        .search_2_xlarge = "search.2xlarge",
        .search_previousgeneration_small = "search.previousgeneration.small",
        .search_previousgeneration_large = "search.previousgeneration.large",
        .search_previousgeneration_xlarge = "search.previousgeneration.xlarge",
        .search_previousgeneration_2_xlarge = "search.previousgeneration.2xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .search_m_1_small => "search.m1.small",
            .search_m_1_large => "search.m1.large",
            .search_m_2_xlarge => "search.m2.xlarge",
            .search_m_2_2_xlarge => "search.m2.2xlarge",
            .search_m_3_medium => "search.m3.medium",
            .search_m_3_large => "search.m3.large",
            .search_m_3_xlarge => "search.m3.xlarge",
            .search_m_3_2_xlarge => "search.m3.2xlarge",
            .search_small => "search.small",
            .search_medium => "search.medium",
            .search_large => "search.large",
            .search_xlarge => "search.xlarge",
            .search_2_xlarge => "search.2xlarge",
            .search_previousgeneration_small => "search.previousgeneration.small",
            .search_previousgeneration_large => "search.previousgeneration.large",
            .search_previousgeneration_xlarge => "search.previousgeneration.xlarge",
            .search_previousgeneration_2_xlarge => "search.previousgeneration.2xlarge",
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
