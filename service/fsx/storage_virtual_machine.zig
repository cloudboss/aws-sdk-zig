const SvmActiveDirectoryConfiguration = @import("svm_active_directory_configuration.zig").SvmActiveDirectoryConfiguration;
const SvmEndpoints = @import("svm_endpoints.zig").SvmEndpoints;
const StorageVirtualMachineLifecycle = @import("storage_virtual_machine_lifecycle.zig").StorageVirtualMachineLifecycle;
const LifecycleTransitionReason = @import("lifecycle_transition_reason.zig").LifecycleTransitionReason;
const StorageVirtualMachineRootVolumeSecurityStyle = @import("storage_virtual_machine_root_volume_security_style.zig").StorageVirtualMachineRootVolumeSecurityStyle;
const StorageVirtualMachineSubtype = @import("storage_virtual_machine_subtype.zig").StorageVirtualMachineSubtype;
const Tag = @import("tag.zig").Tag;

/// Describes the Amazon FSx for NetApp ONTAP storage virtual machine (SVM)
/// configuration.
pub const StorageVirtualMachine = struct {
    /// Describes the Microsoft Active Directory configuration to which the SVM is
    /// joined, if applicable.
    active_directory_configuration: ?SvmActiveDirectoryConfiguration,

    creation_time: ?i64,

    /// The endpoints that are used to access data or to manage the SVM
    /// using the NetApp ONTAP CLI, REST API, or NetApp CloudManager. They
    /// are the `Iscsi`, `Management`, `Nfs`,
    /// and `Smb` endpoints.
    endpoints: ?SvmEndpoints,

    file_system_id: ?[]const u8,

    /// Describes the SVM's lifecycle status.
    ///
    /// * `CREATED` - The SVM is fully available for use.
    ///
    /// * `CREATING` - Amazon FSx is creating the new SVM.
    ///
    /// * `DELETING` - Amazon FSx is deleting an existing SVM.
    ///
    /// * `FAILED` - Amazon FSx was unable to create the SVM.
    ///
    /// * `MISCONFIGURED` - The SVM is in a failed but recoverable state.
    ///
    /// * `PENDING` - Amazon FSx has not started creating the SVM.
    lifecycle: ?StorageVirtualMachineLifecycle,

    /// Describes why the SVM lifecycle state changed.
    lifecycle_transition_reason: ?LifecycleTransitionReason,

    /// The name of the SVM, if provisioned.
    name: ?[]const u8,

    resource_arn: ?[]const u8,

    /// The security style of the root volume of the SVM.
    root_volume_security_style: ?StorageVirtualMachineRootVolumeSecurityStyle,

    /// The SVM's system generated unique ID.
    storage_virtual_machine_id: ?[]const u8,

    /// Describes the SVM's subtype.
    subtype: ?StorageVirtualMachineSubtype,

    tags: ?[]const Tag,

    /// The SVM's UUID (universally unique identifier).
    uuid: ?[]const u8,

    pub const json_field_names = .{
        .active_directory_configuration = "ActiveDirectoryConfiguration",
        .creation_time = "CreationTime",
        .endpoints = "Endpoints",
        .file_system_id = "FileSystemId",
        .lifecycle = "Lifecycle",
        .lifecycle_transition_reason = "LifecycleTransitionReason",
        .name = "Name",
        .resource_arn = "ResourceARN",
        .root_volume_security_style = "RootVolumeSecurityStyle",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
        .subtype = "Subtype",
        .tags = "Tags",
        .uuid = "UUID",
    };
};
