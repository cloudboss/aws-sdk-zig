pub const StepType = enum {
    create_ebs_snapshot,
    delete_ebs_volume,
    modify_ebs_volume,
    create_ebs_volume,

    pub const json_field_names = .{
        .create_ebs_snapshot = "CREATE_EBS_SNAPSHOT",
        .delete_ebs_volume = "DELETE_EBS_VOLUME",
        .modify_ebs_volume = "MODIFY_EBS_VOLUME",
        .create_ebs_volume = "CREATE_EBS_VOLUME",
    };
};
