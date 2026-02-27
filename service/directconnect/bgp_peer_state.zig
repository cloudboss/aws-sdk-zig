pub const BGPPeerState = enum {
    verifying,
    pending,
    available,
    deleting,
    deleted,

    pub const json_field_names = .{
        .verifying = "Verifying",
        .pending = "Pending",
        .available = "Available",
        .deleting = "Deleting",
        .deleted = "Deleted",
    };
};
