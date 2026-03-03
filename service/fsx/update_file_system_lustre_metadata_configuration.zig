const MetadataConfigurationMode = @import("metadata_configuration_mode.zig").MetadataConfigurationMode;

/// The Lustre metadata performance configuration update for an Amazon FSx for
/// Lustre
/// file system using a `PERSISTENT_2` deployment type. You can request
/// an increase in your file system's Metadata IOPS and/or switch your file
/// system's
/// metadata configuration mode. For more information, see [Managing
/// metadata
/// performance](https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-metadata-performance.html) in the
/// *Amazon FSx for Lustre User Guide*.
pub const UpdateFileSystemLustreMetadataConfiguration = struct {
    /// (USER_PROVISIONED mode only) Specifies the number of Metadata IOPS to
    /// provision
    /// for your file system.
    ///
    /// * For SSD file systems, valid values are `1500`,
    /// `3000`, `6000`, `12000`, and
    /// multiples of `12000` up to a maximum of `192000`.
    ///
    /// * For Intelligent-Tiering file systems, valid values are `6000`
    /// and `12000`.
    ///
    /// The value you provide must be greater than or equal to the current number of
    /// Metadata IOPS provisioned for the file system.
    iops: ?i32 = null,

    /// The metadata configuration mode for provisioning Metadata IOPS for
    /// an FSx for Lustre file system using a `PERSISTENT_2`
    /// deployment type.
    ///
    /// * To increase the Metadata IOPS or to switch an SSD file system from
    /// AUTOMATIC,
    /// specify `USER_PROVISIONED` as the value for this parameter. Then use the
    /// Iops parameter to provide a Metadata IOPS value that is greater than or
    /// equal to
    /// the current number of Metadata IOPS provisioned for the file system.
    ///
    /// * To switch from USER_PROVISIONED mode on an SSD file system, specify
    /// `AUTOMATIC` as the value for this parameter, but do not input a value
    /// for Iops.
    ///
    /// * If you request to switch from USER_PROVISIONED to AUTOMATIC mode and the
    /// current Metadata IOPS value is greater than the automated default, FSx for
    /// Lustre
    /// rejects the request because downscaling Metadata IOPS is not supported.
    ///
    /// * AUTOMATIC mode is not supported on Intelligent-Tiering
    /// file systems. For Intelligent-Tiering file systems, use USER_PROVISIONED
    /// mode.
    mode: ?MetadataConfigurationMode = null,

    pub const json_field_names = .{
        .iops = "Iops",
        .mode = "Mode",
    };
};
