/// A network configuration parameter to provide to the Container Network
/// Interface (CNI) plugin.
pub const AwsEcsTaskDefinitionProxyConfigurationProxyConfigurationPropertiesDetails = struct {
    /// The name of the property.
    name: ?[]const u8,

    /// The value of the property.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
