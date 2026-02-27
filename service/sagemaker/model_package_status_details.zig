const ModelPackageStatusItem = @import("model_package_status_item.zig").ModelPackageStatusItem;

/// Specifies the validation and image scan statuses of the model package.
pub const ModelPackageStatusDetails = struct {
    /// The status of the scan of the Docker image container for the model package.
    image_scan_statuses: ?[]const ModelPackageStatusItem,

    /// The validation status of the model package.
    validation_statuses: []const ModelPackageStatusItem,

    pub const json_field_names = .{
        .image_scan_statuses = "ImageScanStatuses",
        .validation_statuses = "ValidationStatuses",
    };
};
