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
        .resource_type = "RESOURCE_TYPE",
        .recommended_action_type = "RECOMMENDED_ACTION_TYPE",
        .resource_id = "RESOURCE_ID",
        .look_back_period_in_days = "LOOK_BACK_PERIOD_IN_DAYS",
        .current_resource_details_ebs_volume_type = "CURRENT_RESOURCE_DETAILS_EBS_VOLUME_TYPE",
        .resource_tags_key = "RESOURCE_TAGS_KEY",
        .resource_tags_value = "RESOURCE_TAGS_VALUE",
        .account_id = "ACCOUNT_ID",
        .restart_needed = "RESTART_NEEDED",
    };
};
