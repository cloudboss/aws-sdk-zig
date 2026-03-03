/// Indicates the current configuration of the block storage capability on your
/// EKS Auto
/// Mode cluster. For example, if the capability is enabled or disabled. If the
/// block
/// storage capability is enabled, EKS Auto Mode will create and delete EBS
/// volumes in your
/// Amazon Web Services account. For more information, see EKS Auto Mode block
/// storage capability in the
/// *Amazon EKS User Guide*.
pub const BlockStorage = struct {
    /// Indicates if the block storage capability is enabled on your EKS Auto Mode
    /// cluster. If
    /// the block storage capability is enabled, EKS Auto Mode will create and
    /// delete EBS
    /// volumes in your Amazon Web Services account.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
