const ManagedMicrovmImageVersionStatus = @import("managed_microvm_image_version_status.zig").ManagedMicrovmImageVersionStatus;

/// Contains version information for a managed MicroVM image.
pub const ManagedMicrovmImageVersion = struct {
    /// The timestamp when the version was created.
    created_at: i64,

    /// The ARN of the managed MicroVM image.
    image_arn: []const u8,

    /// The version of the managed MicroVM image.
    image_version: []const u8,

    /// The lifecycle status of the managed MicroVM image version. Valid values:
    /// AVAILABLE (the version is available for use) or DEPRECATED (the version is
    /// deprecated; do not use it for new MicroVM images).
    status: ?ManagedMicrovmImageVersionStatus = null,

    /// The timestamp when the version was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
