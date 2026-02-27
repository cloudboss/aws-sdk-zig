pub const WorkflowStepType = enum {
    copy,
    custom,
    tag,
    delete,
    decrypt,

    pub const json_field_names = .{
        .copy = "COPY",
        .custom = "CUSTOM",
        .tag = "TAG",
        .delete = "DELETE",
        .decrypt = "DECRYPT",
    };
};
