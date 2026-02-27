pub const ListEdgePackagingJobsSortBy = enum {
    name,
    model_name,
    creation_time,
    last_modified_time,
    edge_packaging_job_status,

    pub const json_field_names = .{
        .name = "Name",
        .model_name = "ModelName",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .edge_packaging_job_status = "EdgePackagingJobStatus",
    };
};
