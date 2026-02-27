pub const IdentityResolutionJobStatus = enum {
    pending,
    preprocessing,
    find_matching,
    merging,
    completed,
    partial_success,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .preprocessing = "PREPROCESSING",
        .find_matching = "FIND_MATCHING",
        .merging = "MERGING",
        .completed = "COMPLETED",
        .partial_success = "PARTIAL_SUCCESS",
        .failed = "FAILED",
    };
};
