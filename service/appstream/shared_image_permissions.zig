const ImagePermissions = @import("image_permissions.zig").ImagePermissions;

/// Describes the permissions that are available to the specified AWS account
/// for a shared image.
pub const SharedImagePermissions = struct {
    /// Describes the permissions for a shared image.
    image_permissions: ImagePermissions,

    /// The 12-digit identifier of the AWS account with which the image is shared.
    shared_account_id: []const u8,

    pub const json_field_names = .{
        .image_permissions = "imagePermissions",
        .shared_account_id = "sharedAccountId",
    };
};
