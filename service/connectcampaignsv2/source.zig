const EventTrigger = @import("event_trigger.zig").EventTrigger;

/// Source of the campaign
pub const Source = union(enum) {
    customer_profiles_segment_arn: ?[]const u8,
    event_trigger: ?EventTrigger,

    pub const json_field_names = .{
        .customer_profiles_segment_arn = "customerProfilesSegmentArn",
        .event_trigger = "eventTrigger",
    };
};
