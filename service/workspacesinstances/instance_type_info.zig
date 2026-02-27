const SupportedInstanceConfiguration = @import("supported_instance_configuration.zig").SupportedInstanceConfiguration;

/// Provides details about a specific WorkSpace Instance type.
pub const InstanceTypeInfo = struct {
    /// Unique identifier for the WorkSpace Instance type.
    instance_type: ?[]const u8,

    /// Lists all valid combinations of tenancy, platform type, and billing mode
    /// supported for the specific WorkSpace Instance type. Contains the complete
    /// set of configuration options available for this instance type.
    supported_instance_configurations: ?[]const SupportedInstanceConfiguration,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .supported_instance_configurations = "SupportedInstanceConfigurations",
    };
};
