/// Network configuration settings for inbound network traffic.
pub const IngressConfiguration = struct {
    /// Specifies whether your App Runner service is publicly accessible. To make
    /// the service publicly accessible set it to `True`. To make the service
    /// privately accessible, from only within an Amazon VPC set it to `False`.
    is_publicly_accessible: bool = false,

    pub const json_field_names = .{
        .is_publicly_accessible = "IsPubliclyAccessible",
    };
};
