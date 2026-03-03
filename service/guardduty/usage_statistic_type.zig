const std = @import("std");

pub const UsageStatisticType = enum {
    sum_by_account,
    sum_by_data_source,
    sum_by_resource,
    top_resources,
    sum_by_features,
    top_accounts_by_feature,

    pub const json_field_names = .{
        .sum_by_account = "SUM_BY_ACCOUNT",
        .sum_by_data_source = "SUM_BY_DATA_SOURCE",
        .sum_by_resource = "SUM_BY_RESOURCE",
        .top_resources = "TOP_RESOURCES",
        .sum_by_features = "SUM_BY_FEATURES",
        .top_accounts_by_feature = "TOP_ACCOUNTS_BY_FEATURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum_by_account => "SUM_BY_ACCOUNT",
            .sum_by_data_source => "SUM_BY_DATA_SOURCE",
            .sum_by_resource => "SUM_BY_RESOURCE",
            .top_resources => "TOP_RESOURCES",
            .sum_by_features => "SUM_BY_FEATURES",
            .top_accounts_by_feature => "TOP_ACCOUNTS_BY_FEATURE",
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
