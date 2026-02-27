/// The service for a cross account role.
pub const Service = struct {
    /// The cluster Amazon Resource Name (ARN) for a service.
    cluster_arn: ?[]const u8,

    /// The cross account role for a service.
    cross_account_role: ?[]const u8,

    /// The external ID (secret key) for the service.
    external_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) for a service.
    service_arn: ?[]const u8,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .service_arn = "serviceArn",
    };
};
