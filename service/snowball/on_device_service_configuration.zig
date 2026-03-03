const EKSOnDeviceServiceConfiguration = @import("eks_on_device_service_configuration.zig").EKSOnDeviceServiceConfiguration;
const NFSOnDeviceServiceConfiguration = @import("nfs_on_device_service_configuration.zig").NFSOnDeviceServiceConfiguration;
const S3OnDeviceServiceConfiguration = @import("s3_on_device_service_configuration.zig").S3OnDeviceServiceConfiguration;
const TGWOnDeviceServiceConfiguration = @import("tgw_on_device_service_configuration.zig").TGWOnDeviceServiceConfiguration;

/// An object that represents the metadata and configuration settings for
/// services on an Amazon Web Services
/// Snow Family device.
pub const OnDeviceServiceConfiguration = struct {
    /// The configuration of EKS Anywhere on the Snow Family device.
    eks_on_device_service: ?EKSOnDeviceServiceConfiguration = null,

    /// Represents the NFS (Network File System) service on a Snow Family device.
    nfs_on_device_service: ?NFSOnDeviceServiceConfiguration = null,

    /// Configuration for Amazon S3 compatible storage on Snow family devices.
    s3_on_device_service: ?S3OnDeviceServiceConfiguration = null,

    /// Represents the Storage Gateway service Tape Gateway type on a Snow Family
    /// device.
    tgw_on_device_service: ?TGWOnDeviceServiceConfiguration = null,

    pub const json_field_names = .{
        .eks_on_device_service = "EKSOnDeviceService",
        .nfs_on_device_service = "NFSOnDeviceService",
        .s3_on_device_service = "S3OnDeviceService",
        .tgw_on_device_service = "TGWOnDeviceService",
    };
};
