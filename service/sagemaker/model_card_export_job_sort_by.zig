/// Attribute by which to sort returned export jobs.
pub const ModelCardExportJobSortBy = enum {
    name,
    creation_time,
    status,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_time = "CREATION_TIME",
        .status = "STATUS",
    };
};
