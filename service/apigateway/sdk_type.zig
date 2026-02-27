const SdkConfigurationProperty = @import("sdk_configuration_property.zig").SdkConfigurationProperty;

/// A type of SDK that API Gateway can generate.
pub const SdkType = struct {
    /// A list of configuration properties of an SdkType.
    configuration_properties: ?[]const SdkConfigurationProperty,

    /// The description of an SdkType.
    description: ?[]const u8,

    /// The user-friendly name of an SdkType instance.
    friendly_name: ?[]const u8,

    /// The identifier of an SdkType instance.
    id: ?[]const u8,

    pub const json_field_names = .{
        .configuration_properties = "configurationProperties",
        .description = "description",
        .friendly_name = "friendlyName",
        .id = "id",
    };
};
