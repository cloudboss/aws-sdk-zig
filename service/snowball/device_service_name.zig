pub const DeviceServiceName = enum {
    nfs_on_device_service,
    s3_on_device_service,

    pub const json_field_names = .{
        .nfs_on_device_service = "NFS_ON_DEVICE_SERVICE",
        .s3_on_device_service = "S3_ON_DEVICE_SERVICE",
    };
};
