/// Event type enumeration
pub const EventType = enum {
    snapshot_and_delete_unattached_ebs_volume,
    upgrade_ebs_volume_type,

    pub const json_field_names = .{
        .snapshot_and_delete_unattached_ebs_volume = "SNAPSHOT_AND_DELETE_UNATTACHED_EBS_VOLUME",
        .upgrade_ebs_volume_type = "UPGRADE_EBS_VOLUME_TYPE",
    };
};
