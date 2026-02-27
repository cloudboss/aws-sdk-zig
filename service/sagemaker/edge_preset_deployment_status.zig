pub const EdgePresetDeploymentStatus = enum {
    completed,
    failed,

    pub const json_field_names = .{
        .completed = "Completed",
        .failed = "Failed",
    };
};
