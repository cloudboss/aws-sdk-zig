const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelLifeCycle = @import("model_life_cycle.zig").ModelLifeCycle;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;
const ModelPackageStatus = @import("model_package_status.zig").ModelPackageStatus;

/// Provides summary information about a model package.
pub const ModelPackageSummary = struct {
    /// A timestamp that shows when the model package was created.
    creation_time: i64,

    /// The approval status of the model. This can be one of the following values.
    ///
    /// * `APPROVED` - The model is approved
    /// * `REJECTED` - The model is rejected.
    /// * `PENDING_MANUAL_APPROVAL` - The model is waiting for manual approval.
    model_approval_status: ?ModelApprovalStatus = null,

    model_life_cycle: ?ModelLifeCycle = null,

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: []const u8,

    /// A brief description of the model package.
    model_package_description: ?[]const u8 = null,

    /// If the model package is a versioned model, the model group that the
    /// versioned model belongs to.
    model_package_group_name: ?[]const u8 = null,

    /// The name of the model package.
    model_package_name: ?[]const u8 = null,

    /// The package registration type of the model package summary.
    model_package_registration_type: ?ModelPackageRegistrationType = null,

    /// The overall status of the model package.
    model_package_status: ModelPackageStatus,

    /// If the model package is a versioned model, the version of the model.
    model_package_version: ?i32 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .model_approval_status = "ModelApprovalStatus",
        .model_life_cycle = "ModelLifeCycle",
        .model_package_arn = "ModelPackageArn",
        .model_package_description = "ModelPackageDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_name = "ModelPackageName",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .model_package_status = "ModelPackageStatus",
        .model_package_version = "ModelPackageVersion",
    };
};
