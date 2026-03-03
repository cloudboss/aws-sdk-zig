const DiskIopsConfigurationMode = @import("disk_iops_configuration_mode.zig").DiskIopsConfigurationMode;

/// The SSD IOPS (input/output operations per second) configuration for an
/// Amazon FSx for NetApp ONTAP, Amazon FSx for Windows File Server, or FSx for
/// OpenZFS file system. By default, Amazon FSx
/// automatically provisions 3 IOPS per GB of storage capacity. You can
/// provision additional IOPS per
/// GB of storage. The configuration consists of the total number of provisioned
/// SSD IOPS
/// and how it is was provisioned, or the mode (by the customer or by Amazon
/// FSx).
pub const DiskIopsConfiguration = struct {
    /// The total number of SSD IOPS provisioned for the file system.
    ///
    /// The minimum and maximum values for this property depend on the value of
    /// `HAPairs` and `StorageCapacity`. The minimum value is calculated as
    /// `StorageCapacity` * 3 * `HAPairs` (3 IOPS per GB of `StorageCapacity`). The
    /// maximum value is calculated as 200,000 * `HAPairs`.
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) if the value
    /// of `Iops` is outside of the minimum or maximum values.
    iops: ?i64 = null,

    /// Specifies whether the file system is
    /// using the `AUTOMATIC` setting of SSD IOPS of 3 IOPS per GB of storage
    /// capacity, or
    /// if it using a `USER_PROVISIONED` value.
    mode: ?DiskIopsConfigurationMode = null,

    pub const json_field_names = .{
        .iops = "Iops",
        .mode = "Mode",
    };
};
