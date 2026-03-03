const LicenseConversionContext = @import("license_conversion_context.zig").LicenseConversionContext;
const LicenseConversionTaskStatus = @import("license_conversion_task_status.zig").LicenseConversionTaskStatus;

/// Information about a license type conversion task.
pub const LicenseConversionTask = struct {
    /// Information about the license type this conversion task converted to.
    destination_license_context: ?LicenseConversionContext = null,

    /// The time the conversion task was completed.
    end_time: ?i64 = null,

    /// The ID of the license type conversion task.
    license_conversion_task_id: ?[]const u8 = null,

    /// The time the usage operation value of the resource was changed.
    license_conversion_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the resource associated with the license
    /// type
    /// conversion task.
    resource_arn: ?[]const u8 = null,

    /// Information about the license type this conversion task converted from.
    source_license_context: ?LicenseConversionContext = null,

    /// The time the conversion task was started at.
    start_time: ?i64 = null,

    /// The status of the conversion task.
    status: ?LicenseConversionTaskStatus = null,

    /// The status message for the conversion task.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_license_context = "DestinationLicenseContext",
        .end_time = "EndTime",
        .license_conversion_task_id = "LicenseConversionTaskId",
        .license_conversion_time = "LicenseConversionTime",
        .resource_arn = "ResourceArn",
        .source_license_context = "SourceLicenseContext",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
