const AlgorithmStatusItem = @import("algorithm_status_item.zig").AlgorithmStatusItem;

/// Specifies the validation and image scan statuses of the algorithm.
pub const AlgorithmStatusDetails = struct {
    /// The status of the scan of the algorithm's Docker image container.
    image_scan_statuses: ?[]const AlgorithmStatusItem = null,

    /// The status of algorithm validation.
    validation_statuses: ?[]const AlgorithmStatusItem = null,

    pub const json_field_names = .{
        .image_scan_statuses = "ImageScanStatuses",
        .validation_statuses = "ValidationStatuses",
    };
};
