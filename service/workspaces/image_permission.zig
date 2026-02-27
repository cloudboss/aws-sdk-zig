/// Describes the Amazon Web Services accounts that have been granted permission
/// to use a
/// shared image. For more information about sharing images, see [ Share or
/// Unshare a Custom
/// WorkSpaces
/// Image](https://docs.aws.amazon.com/workspaces/latest/adminguide/share-custom-image.html).
pub const ImagePermission = struct {
    /// The identifier of the Amazon Web Services account that an image has been
    /// shared
    /// with.
    shared_account_id: ?[]const u8,

    pub const json_field_names = .{
        .shared_account_id = "SharedAccountId",
    };
};
