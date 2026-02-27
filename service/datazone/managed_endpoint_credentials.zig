/// The managed endpoint credentials of the EMR on EKS cluster.
pub const ManagedEndpointCredentials = struct {
    /// The identifier of the managed endpoint credentials.
    id: ?[]const u8,

    /// The ARN of the managed endpoint credentials.
    token: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .token = "token",
    };
};
