pub const CapacityProviderState = enum {
    pending,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .pending = "Pending",
        .active = "Active",
        .failed = "Failed",
        .deleting = "Deleting",
    };
};
