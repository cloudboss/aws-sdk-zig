const DetailedModelPackageStatus = @import("detailed_model_package_status.zig").DetailedModelPackageStatus;

/// Represents the overall status of a model package.
pub const ModelPackageStatusItem = struct {
    /// if the overall status is `Failed`, the reason for the failure.
    failure_reason: ?[]const u8,

    /// The name of the model package for which the overall status is being
    /// reported.
    name: []const u8,

    /// The current status.
    status: DetailedModelPackageStatus,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .name = "Name",
        .status = "Status",
    };
};
