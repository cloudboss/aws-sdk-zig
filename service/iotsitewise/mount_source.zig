const S3AccessPointSource = @import("s3_access_point_source.zig").S3AccessPointSource;

/// The data source configuration for a mount. Specify exactly one of the
/// following.
pub const MountSource = union(enum) {
    /// Configuration for a mount that reads from an Amazon S3 access point.
    s_3_access_point: ?S3AccessPointSource,

    pub const json_field_names = .{
        .s_3_access_point = "s3AccessPoint",
    };
};
