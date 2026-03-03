const AquaConfigurationStatus = @import("aqua_configuration_status.zig").AquaConfigurationStatus;
const AquaStatus = @import("aqua_status.zig").AquaStatus;

/// The operation that uses this structure is retired. Amazon Redshift
/// automatically determines whether to use AQUA (Advanced Query Accelerator).
pub const AquaConfiguration = struct {
    /// This field is retired. Amazon Redshift automatically determines whether to
    /// use AQUA (Advanced Query Accelerator).
    aqua_configuration_status: ?AquaConfigurationStatus = null,

    /// This field is retired. Amazon Redshift automatically determines whether to
    /// use AQUA (Advanced Query Accelerator).
    aqua_status: ?AquaStatus = null,
};
