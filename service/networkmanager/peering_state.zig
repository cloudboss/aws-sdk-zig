pub const PeeringState = enum {
    creating,
    failed,
    available,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .failed = "FAILED",
        .available = "AVAILABLE",
        .deleting = "DELETING",
    };
};
