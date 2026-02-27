const MetadataConfigurationMode = @import("metadata_configuration_mode.zig").MetadataConfigurationMode;

/// The Lustre metadata performance configuration for the creation of an
/// Amazon FSx for Lustre file system using a `PERSISTENT_2`
/// deployment type. The configuration uses a Metadata IOPS value to set the
/// maximum rate of metadata disk IOPS supported by the file system.
///
/// After creation, the file system supports increasing metadata performance.
/// For more information on Metadata IOPS, see [Lustre
/// metadata performance
/// configuration](https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-metadata-performance.html#metadata-configuration) in the *Amazon FSx for Lustre User Guide*.
pub const CreateFileSystemLustreMetadataConfiguration = struct {
    /// (USER_PROVISIONED mode only) Specifies the number of Metadata IOPS to
    /// provision
    /// for the file system. This parameter sets the maximum rate of metadata disk
    /// IOPS
    /// supported by the file system.
    ///
    /// * For SSD file systems, valid values are `1500`,
    /// `3000`, `6000`, `12000`, and
    /// multiples of `12000` up to a maximum of `192000`.
    ///
    /// * For Intelligent-Tiering file systems, valid values are `6000`
    /// and `12000`.
    ///
    /// `Iops` doesn’t have a default value. If you're using USER_PROVISIONED mode,
    /// you can choose to specify a valid value. If you're using AUTOMATIC mode,
    /// you cannot specify a value because FSx for Lustre automatically sets
    /// the value based on your file system storage capacity.
    iops: ?i32,

    /// The metadata configuration mode for provisioning Metadata IOPS for
    /// an FSx for Lustre file system using a `PERSISTENT_2`
    /// deployment type.
    ///
    /// * In AUTOMATIC mode (supported only on SSD file systems),
    /// FSx for Lustre automatically provisions and scales the
    /// number of Metadata IOPS for your file system
    /// based on your file system storage capacity.
    ///
    /// * In USER_PROVISIONED mode, you specify the number of Metadata
    /// IOPS to provision for your file system.
    mode: MetadataConfigurationMode,

    pub const json_field_names = .{
        .iops = "Iops",
        .mode = "Mode",
    };
};
