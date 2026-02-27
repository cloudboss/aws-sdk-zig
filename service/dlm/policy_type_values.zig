pub const PolicyTypeValues = enum {
    ebs_snapshot_management,
    image_management,
    event_based_policy,

    pub const json_field_names = .{
        .ebs_snapshot_management = "EBS_SNAPSHOT_MANAGEMENT",
        .image_management = "IMAGE_MANAGEMENT",
        .event_based_policy = "EVENT_BASED_POLICY",
    };
};
