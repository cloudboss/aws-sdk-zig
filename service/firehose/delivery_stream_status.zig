pub const DeliveryStreamStatus = enum {
    creating,
    creating_failed,
    deleting,
    deleting_failed,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .creating_failed = "CREATING_FAILED",
        .deleting = "DELETING",
        .deleting_failed = "DELETING_FAILED",
        .active = "ACTIVE",
    };
};
