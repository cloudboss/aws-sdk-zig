pub const SchemaStatus = enum {
    processing,
    active,
    deleting,
    failed,
    success,
    not_applicable,

    pub const json_field_names = .{
        .processing = "Processing",
        .active = "Active",
        .deleting = "Deleting",
        .failed = "Failed",
        .success = "Success",
        .not_applicable = "NotApplicable",
    };
};
