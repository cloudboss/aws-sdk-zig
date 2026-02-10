const BootModeValues = @import("boot_mode_values.zig").BootModeValues;
const ImportImageLicenseConfigurationResponse = @import("import_image_license_configuration_response.zig").ImportImageLicenseConfigurationResponse;
const SnapshotDetail = @import("snapshot_detail.zig").SnapshotDetail;
const Tag = @import("tag.zig").Tag;

/// Describes an import image task.
pub const ImportImageTask = struct {
    /// The architecture of the virtual machine.
    ///
    /// Valid values: `i386` | `x86_64` | `arm64`
    architecture: ?[]const u8,

    /// The boot mode of the virtual machine.
    boot_mode: ?BootModeValues,

    /// A description of the import task.
    description: ?[]const u8,

    /// Indicates whether the image is encrypted.
    encrypted: ?bool,

    /// The target hypervisor for the import task.
    ///
    /// Valid values: `xen`
    hypervisor: ?[]const u8,

    /// The ID of the Amazon Machine Image (AMI) of the imported virtual machine.
    image_id: ?[]const u8,

    /// The ID of the import image task.
    import_task_id: ?[]const u8,

    /// The identifier for the KMS key that was used to create the encrypted image.
    kms_key_id: ?[]const u8,

    /// The ARNs of the license configurations that are associated with the import
    /// image task.
    license_specifications: ?[]const ImportImageLicenseConfigurationResponse,

    /// The license type of the virtual machine.
    license_type: ?[]const u8,

    /// The description string for the import image task.
    platform: ?[]const u8,

    /// The percentage of progress of the import image task.
    progress: ?[]const u8,

    /// Information about the snapshots.
    snapshot_details: ?[]const SnapshotDetail,

    /// A brief status for the import image task.
    status: ?[]const u8,

    /// A descriptive status message for the import image task.
    status_message: ?[]const u8,

    /// The tags for the import image task.
    tags: ?[]const Tag,

    /// The usage operation value.
    usage_operation: ?[]const u8,
};
