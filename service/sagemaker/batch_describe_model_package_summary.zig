const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;
const ModelPackageStatus = @import("model_package_status.zig").ModelPackageStatus;

/// Provides summary information about the model package.
pub const BatchDescribeModelPackageSummary = struct {
    /// The creation time of the mortgage package summary.
    creation_time: i64,

    inference_specification: InferenceSpecification,

    /// The approval status of the model.
    model_approval_status: ?ModelApprovalStatus,

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: []const u8,

    /// The description of the model package.
    model_package_description: ?[]const u8,

    /// The group name for the model package
    model_package_group_name: []const u8,

    /// The package registration type of the model package summary.
    model_package_registration_type: ?ModelPackageRegistrationType,

    /// The status of the mortgage package.
    model_package_status: ModelPackageStatus,

    /// The version number of a versioned model.
    model_package_version: ?i32,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .inference_specification = "InferenceSpecification",
        .model_approval_status = "ModelApprovalStatus",
        .model_package_arn = "ModelPackageArn",
        .model_package_description = "ModelPackageDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .model_package_status = "ModelPackageStatus",
        .model_package_version = "ModelPackageVersion",
    };
};
