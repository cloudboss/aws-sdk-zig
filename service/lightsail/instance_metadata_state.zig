pub const InstanceMetadataState = enum {
    pending,
    applied,

    pub const json_field_names = .{
        .pending = "pending",
        .applied = "applied",
    };
};
