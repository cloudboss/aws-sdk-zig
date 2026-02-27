/// The property to sort the results by. Valid values are:
pub const ListJobsSortAttributeName = enum {
    created_at,
    job_status,
    name,
    job_type,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .job_status = "jobStatus",
        .name = "name",
        .job_type = "jobType",
    };
};
