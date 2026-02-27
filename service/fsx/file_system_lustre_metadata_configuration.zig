const MetadataConfigurationMode = @import("metadata_configuration_mode.zig").MetadataConfigurationMode;

/// The Lustre metadata performance configuration of an Amazon FSx for Lustre
/// file system using a `PERSISTENT_2` deployment type. The configuration
/// enables the file system to support increasing metadata performance.
pub const FileSystemLustreMetadataConfiguration = struct {
    /// The number of Metadata IOPS provisioned for the file system.
    ///
    /// * For SSD file systems, valid values are `1500`,
    /// `3000`, `6000`, `12000`, and
    /// multiples of `12000` up to a maximum of `192000`.
    ///
    /// * For Intelligent-Tiering file systems, valid values are `6000`
    /// and `12000`.
    iops: ?i32,

    /// The metadata configuration mode for provisioning Metadata IOPS for the
    /// file system.
    ///
    /// * In AUTOMATIC mode (supported only on SSD file systems),
    /// FSx for Lustre automatically provisions and scales the
    /// number of Metadata IOPS on your file system based on your file
    /// system storage capacity.
    ///
    /// * In USER_PROVISIONED mode, you can choose to specify the number
    /// of Metadata IOPS to provision for your file system.
    mode: MetadataConfigurationMode,

    pub const json_field_names = .{
        .iops = "Iops",
        .mode = "Mode",
    };
};
