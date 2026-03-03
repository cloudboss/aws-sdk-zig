const ErrorDetails = @import("error_details.zig").ErrorDetails;
const SoftwareDeploymentStatus = @import("software_deployment_status.zig").SoftwareDeploymentStatus;

/// The association between a license-included application and a resource.
pub const SoftwareAssociations = struct {
    /// The error details for failed deployments of the license-included
    /// application.
    deployment_error: ?[]const ErrorDetails = null,

    /// The name of the license-included application.
    ///
    /// Possible values include the following:
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Project_2021_Professional_32Bit
    ///
    /// * Microsoft_Project_2021_Professional_64Bit
    ///
    /// * Microsoft_Project_2024_Professional_32Bit
    ///
    /// * Microsoft_Project_2024_Professional_64Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Project_2021_Standard_32Bit
    ///
    /// * Microsoft_Project_2021_Standard_64Bit
    ///
    /// * Microsoft_Project_2024_Standard_32Bit
    ///
    /// * Microsoft_Project_2024_Standard_64Bit
    software_name: ?[]const u8 = null,

    /// The deployment status of the license-included application.
    status: ?SoftwareDeploymentStatus = null,

    pub const json_field_names = .{
        .deployment_error = "DeploymentError",
        .software_name = "SoftwareName",
        .status = "Status",
    };
};
