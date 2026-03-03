const DataReplicationSettings = @import("data_replication_settings.zig").DataReplicationSettings;
const ModificationState = @import("modification_state.zig").ModificationState;
const RelatedWorkspaceProperties = @import("related_workspace_properties.zig").RelatedWorkspaceProperties;
const StandbyWorkspacesProperties = @import("standby_workspaces_properties.zig").StandbyWorkspacesProperties;
const WorkspaceState = @import("workspace_state.zig").WorkspaceState;
const WorkspaceProperties = @import("workspace_properties.zig").WorkspaceProperties;

/// Describes a WorkSpace.
pub const Workspace = struct {
    /// The identifier of the bundle used to create the WorkSpace.
    bundle_id: ?[]const u8 = null,

    /// The name of the WorkSpace, as seen by the operating system. The format of
    /// this name
    /// varies. For more information, see [ Launch a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/launch-workspaces-tutorials.html).
    computer_name: ?[]const u8 = null,

    /// Indicates the settings of the data replication.
    data_replication_settings: ?DataReplicationSettings = null,

    /// The identifier of the Directory Service directory for the WorkSpace.
    directory_id: ?[]const u8 = null,

    /// The error code that is returned if the WorkSpace cannot be created.
    error_code: ?[]const u8 = null,

    /// The text of the error message that is returned if the WorkSpace cannot be
    /// created.
    error_message: ?[]const u8 = null,

    /// The IP address of the WorkSpace.
    ip_address: ?[]const u8 = null,

    /// The IPv6 address of the WorkSpace.
    ipv_6_address: ?[]const u8 = null,

    /// The modification states of the WorkSpace.
    modification_states: ?[]const ModificationState = null,

    /// The standby WorkSpace or primary WorkSpace related to the specified
    /// WorkSpace.
    related_workspaces: ?[]const RelatedWorkspaceProperties = null,

    /// Indicates whether the data stored on the root volume is encrypted.
    root_volume_encryption_enabled: ?bool = null,

    /// The properties of the standby WorkSpace
    standby_workspaces_properties: ?[]const StandbyWorkspacesProperties = null,

    /// The operational state of the WorkSpace.
    ///
    /// * `PENDING` – The WorkSpace is in a waiting state (for example, the
    ///   WorkSpace is being created).
    ///
    /// * `AVAILABLE` – The WorkSpace is running and has passed the health checks.
    ///
    /// * `IMPAIRED` – Refer to `UNHEALTHY` state.
    ///
    /// * `UNHEALTHY` – The WorkSpace is not responding to health checks.
    ///
    /// * `REBOOTING` – The WorkSpace is being rebooted (restarted).
    ///
    /// * `STARTING` – The WorkSpace is starting up and health checks are being run.
    ///
    /// * `REBUILDING` – The WorkSpace is being rebuilt.
    ///
    /// * `RESTORING` – The WorkSpace is being restored.
    ///
    /// * `MAINTENANCE` – The WorkSpace is undergoing scheduled maintenance by
    ///   Amazon Web Services.
    ///
    /// * `ADMIN_MAINTENANCE` – The WorkSpace is undergoing maintenance by the
    ///   WorkSpaces administrator.
    ///
    /// * `TERMINATING` – The WorkSpace is being deleted.
    ///
    /// * `TERMINATED` – The WorkSpace has been deleted.
    ///
    /// * `SUSPENDED` – The WorkSpace has been suspended for image creation.
    ///
    /// * `UPDATING` – The WorkSpace is undergoing an update.
    ///
    /// * `STOPPING` – The WorkSpace is being stopped.
    ///
    /// * `STOPPED` – The WorkSpace has been stopped.
    ///
    /// * `ERROR ` – The WorkSpace is an error state (for example, an error occurred
    ///   during startup).
    ///
    /// After a WorkSpace is terminated, the `TERMINATED` state is returned only
    /// briefly before the WorkSpace directory metadata is cleaned up, so this state
    /// is rarely
    /// returned. To confirm that a WorkSpace is terminated, check for the WorkSpace
    /// ID by using
    /// [
    /// DescribeWorkSpaces](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaces.html). If the WorkSpace ID isn't returned, then the WorkSpace
    /// has been successfully terminated.
    state: ?WorkspaceState = null,

    /// The identifier of the subnet for the WorkSpace.
    subnet_id: ?[]const u8 = null,

    /// The user for the WorkSpace.
    user_name: ?[]const u8 = null,

    /// Indicates whether the data stored on the user volume is encrypted.
    user_volume_encryption_enabled: ?bool = null,

    /// The ARN of the symmetric KMS key used to encrypt data stored on your
    /// WorkSpace.
    /// Amazon WorkSpaces does not support asymmetric KMS keys.
    volume_encryption_key: ?[]const u8 = null,

    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8 = null,

    /// The name of the user-decoupled WorkSpace.
    workspace_name: ?[]const u8 = null,

    /// The properties of the WorkSpace.
    workspace_properties: ?WorkspaceProperties = null,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
        .computer_name = "ComputerName",
        .data_replication_settings = "DataReplicationSettings",
        .directory_id = "DirectoryId",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .ip_address = "IpAddress",
        .ipv_6_address = "Ipv6Address",
        .modification_states = "ModificationStates",
        .related_workspaces = "RelatedWorkspaces",
        .root_volume_encryption_enabled = "RootVolumeEncryptionEnabled",
        .standby_workspaces_properties = "StandbyWorkspacesProperties",
        .state = "State",
        .subnet_id = "SubnetId",
        .user_name = "UserName",
        .user_volume_encryption_enabled = "UserVolumeEncryptionEnabled",
        .volume_encryption_key = "VolumeEncryptionKey",
        .workspace_id = "WorkspaceId",
        .workspace_name = "WorkspaceName",
        .workspace_properties = "WorkspaceProperties",
    };
};
