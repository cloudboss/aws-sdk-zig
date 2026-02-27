pub const RestoreDeletionStatus = enum {
    deleting,
    failed,
    successful,

    pub const json_field_names = .{
        .deleting = "DELETING",
        .failed = "FAILED",
        .successful = "SUCCESSFUL",
    };
};
