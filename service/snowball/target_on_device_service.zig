const DeviceServiceName = @import("device_service_name.zig").DeviceServiceName;
const TransferOption = @import("transfer_option.zig").TransferOption;

/// An object that represents the service or services on the Snow Family device
/// that your
/// transferred data will be exported from or imported into. Amazon Web Services
/// Snow Family supports Amazon S3 and
/// NFS (Network File System).
pub const TargetOnDeviceService = struct {
    /// Specifies the name of the service on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into.
    service_name: ?DeviceServiceName,

    /// Specifies whether the data is being imported or exported. You can import or
    /// export the
    /// data, or use it locally on the device.
    transfer_option: ?TransferOption,

    pub const json_field_names = .{
        .service_name = "ServiceName",
        .transfer_option = "TransferOption",
    };
};
