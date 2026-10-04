/// Configures a mount that reads from an Amazon S3 access point.
pub const S3AccessPointSource = struct {
    /// The Amazon Resource Name (ARN) of the S3 access point.
    access_point_arn: []const u8,

    /// An optional key prefix to scope the mount to a subset of objects at the
    /// access point.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .prefix = "prefix",
    };
};
