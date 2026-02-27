/// Specifies the connection endpoint.
pub const AwsRdsDbInstanceEndpoint = struct {
    /// Specifies the DNS address of the DB instance.
    address: ?[]const u8,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8,

    /// Specifies the port that the database engine is listening on.
    port: ?i32,

    pub const json_field_names = .{
        .address = "Address",
        .hosted_zone_id = "HostedZoneId",
        .port = "Port",
    };
};
