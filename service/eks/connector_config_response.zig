/// The full description of your connected cluster.
pub const ConnectorConfigResponse = struct {
    /// A unique code associated with the cluster for registration purposes.
    activation_code: ?[]const u8 = null,

    /// The expiration time of the connected cluster. The cluster's YAML file must
    /// be applied
    /// through the native provider.
    activation_expiry: ?i64 = null,

    /// A unique ID associated with the cluster for registration purposes.
    activation_id: ?[]const u8 = null,

    /// The cluster's cloud service provider.
    provider: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role to communicate with services from
    /// the connected Kubernetes
    /// cluster.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .activation_code = "activationCode",
        .activation_expiry = "activationExpiry",
        .activation_id = "activationId",
        .provider = "provider",
        .role_arn = "roleArn",
    };
};
