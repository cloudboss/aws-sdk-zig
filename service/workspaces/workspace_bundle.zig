const BundleType = @import("bundle_type.zig").BundleType;
const ComputeType = @import("compute_type.zig").ComputeType;
const RootStorage = @import("root_storage.zig").RootStorage;
const WorkspaceBundleState = @import("workspace_bundle_state.zig").WorkspaceBundleState;
const UserStorage = @import("user_storage.zig").UserStorage;

/// Describes a WorkSpace bundle.
pub const WorkspaceBundle = struct {
    /// The identifier of the bundle.
    bundle_id: ?[]const u8,

    /// The type of WorkSpace bundle.
    bundle_type: ?BundleType,

    /// The compute type of the bundle. For more information, see
    /// [Amazon WorkSpaces
    /// Bundles](http://aws.amazon.com/workspaces/details/#Amazon_WorkSpaces_Bundles).
    compute_type: ?ComputeType,

    /// The time when the bundle was created.
    creation_time: ?i64,

    /// The description of the bundle.
    description: ?[]const u8,

    /// The identifier of the image that was used to create the bundle.
    image_id: ?[]const u8,

    /// The last time that the bundle was updated.
    last_updated_time: ?i64,

    /// The name of the bundle.
    name: ?[]const u8,

    /// The owner of the bundle. This is the account identifier of the owner, or
    /// `AMAZON` if the bundle is provided by Amazon Web Services.
    owner: ?[]const u8,

    /// The size of the root volume.
    root_storage: ?RootStorage,

    /// The state of the WorkSpace bundle.
    state: ?WorkspaceBundleState,

    /// The size of the user volume.
    user_storage: ?UserStorage,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
        .bundle_type = "BundleType",
        .compute_type = "ComputeType",
        .creation_time = "CreationTime",
        .description = "Description",
        .image_id = "ImageId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner = "Owner",
        .root_storage = "RootStorage",
        .state = "State",
        .user_storage = "UserStorage",
    };
};
