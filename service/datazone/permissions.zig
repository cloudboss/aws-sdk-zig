const S3Permission = @import("s3_permission.zig").S3Permission;

/// The asset permissions.
pub const Permissions = union(enum) {
    /// The S3 details of the asset permissions.
    s_3: ?[]const S3Permission,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
