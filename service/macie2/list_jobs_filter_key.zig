/// The property to use to filter the results. Valid values are:
pub const ListJobsFilterKey = enum {
    job_type,
    job_status,
    created_at,
    name,

    pub const json_field_names = .{
        .job_type = "jobType",
        .job_status = "jobStatus",
        .created_at = "createdAt",
        .name = "name",
    };
};
