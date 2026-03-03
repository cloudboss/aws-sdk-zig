const TypeConfigurationIdentifier = @import("type_configuration_identifier.zig").TypeConfigurationIdentifier;

/// Detailed information concerning an error generated during the setting of
/// configuration data
/// for a CloudFormation extension.
pub const BatchDescribeTypeConfigurationsError = struct {
    /// The error code.
    error_code: ?[]const u8 = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// Identifying information for the configuration of a CloudFormation extension.
    type_configuration_identifier: ?TypeConfigurationIdentifier = null,
};
