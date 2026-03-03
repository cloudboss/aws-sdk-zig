const std = @import("std");

pub const GroupingRecommendationRejectionReason = enum {
    distinct_business_purpose,
    separate_data_concern,
    distinct_user_group_handling,
    other,

    pub const json_field_names = .{
        .distinct_business_purpose = "DistinctBusinessPurpose",
        .separate_data_concern = "SeparateDataConcern",
        .distinct_user_group_handling = "DistinctUserGroupHandling",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distinct_business_purpose => "DistinctBusinessPurpose",
            .separate_data_concern => "SeparateDataConcern",
            .distinct_user_group_handling => "DistinctUserGroupHandling",
            .other => "Other",
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
