const std = @import("std");

pub const RecommendedActionFilterName = enum {
    resource_type,
    recommended_action_type,
    resource_id,
    look_back_period_in_days,
    current_resource_details_ebs_volume_type,
    resource_tags_key,
    resource_tags_value,
    account_id,
    restart_needed,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .recommended_action_type = "RecommendedActionType",
        .resource_id = "ResourceId",
        .look_back_period_in_days = "LookBackPeriodInDays",
        .current_resource_details_ebs_volume_type = "CurrentResourceDetailsEbsVolumeType",
        .resource_tags_key = "ResourceTagsKey",
        .resource_tags_value = "ResourceTagsValue",
        .account_id = "AccountId",
        .restart_needed = "RestartNeeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "ResourceType",
            .recommended_action_type => "RecommendedActionType",
            .resource_id => "ResourceId",
            .look_back_period_in_days => "LookBackPeriodInDays",
            .current_resource_details_ebs_volume_type => "CurrentResourceDetailsEbsVolumeType",
            .resource_tags_key => "ResourceTagsKey",
            .resource_tags_value => "ResourceTagsValue",
            .account_id => "AccountId",
            .restart_needed => "RestartNeeded",
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
