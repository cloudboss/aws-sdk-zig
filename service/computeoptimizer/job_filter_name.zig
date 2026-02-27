pub const JobFilterName = enum {
    resource_type,
    job_status,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .job_status = "JOB_STATUS",
    };
};
