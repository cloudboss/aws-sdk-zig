const ErrorDetails = @import("error_details.zig").ErrorDetails;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const WorkspaceImageRequiredTenancy = @import("workspace_image_required_tenancy.zig").WorkspaceImageRequiredTenancy;
const WorkspaceImageState = @import("workspace_image_state.zig").WorkspaceImageState;
const UpdateResult = @import("update_result.zig").UpdateResult;

/// Describes a WorkSpace image.
pub const WorkspaceImage = struct {
    /// The date when the image was created. If the image has been shared, the
    /// Amazon Web Services account that the image has been shared with sees the
    /// original creation date
    /// of the image.
    created: ?i64,

    /// The description of the image.
    description: ?[]const u8,

    /// The error code that is returned for the image.
    error_code: ?[]const u8,

    /// Additional details of the error returned for the image, including the
    /// possible causes of the errors and troubleshooting information.
    error_details: ?[]const ErrorDetails,

    /// The text of the error message that is returned for the image.
    error_message: ?[]const u8,

    /// The identifier of the image.
    image_id: ?[]const u8,

    /// The name of the image.
    name: ?[]const u8,

    /// The operating system that the image is running.
    operating_system: ?OperatingSystem,

    /// The identifier of the Amazon Web Services account that owns the image.
    owner_account_id: ?[]const u8,

    /// Specifies whether the image is running on dedicated hardware. When Bring
    /// Your Own
    /// License (BYOL) is enabled, this value is set to `DEDICATED`. For more
    /// information, see [Bring Your Own Windows
    /// Desktop
    /// Images](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    required_tenancy: ?WorkspaceImageRequiredTenancy,

    /// The status of the image.
    state: ?WorkspaceImageState,

    /// The updates (if any) that are available for the specified image.
    updates: ?UpdateResult,

    pub const json_field_names = .{
        .created = "Created",
        .description = "Description",
        .error_code = "ErrorCode",
        .error_details = "ErrorDetails",
        .error_message = "ErrorMessage",
        .image_id = "ImageId",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .owner_account_id = "OwnerAccountId",
        .required_tenancy = "RequiredTenancy",
        .state = "State",
        .updates = "Updates",
    };
};
