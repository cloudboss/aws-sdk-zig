pub const VpcEndpointStatus = enum {
    /// Pending VPCEndpoint resource
    pending,
    /// Deleting VPCEndpoint resource
    deleting,
    /// VPCEndpoint resource is ready to use
    active,
    /// VPCEndpoint resource create or delete failed
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
