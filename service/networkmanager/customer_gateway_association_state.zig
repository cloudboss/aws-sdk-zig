pub const CustomerGatewayAssociationState = enum {
    pending,
    available,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .deleting = "deleting",
        .deleted = "deleted",
    };
};
