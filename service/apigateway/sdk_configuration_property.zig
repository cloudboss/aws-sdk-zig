/// A configuration property of an SDK type.
pub const SdkConfigurationProperty = struct {
    /// The default value of an SdkType configuration property.
    default_value: ?[]const u8,

    /// The description of an SdkType configuration property.
    description: ?[]const u8,

    /// The user-friendly name of an SdkType configuration property.
    friendly_name: ?[]const u8,

    /// The name of a an SdkType configuration property.
    name: ?[]const u8,

    /// A boolean flag of an SdkType configuration property to indicate if the
    /// associated SDK configuration property is required (`true`) or not (`false`).
    required: bool = false,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .friendly_name = "friendlyName",
        .name = "name",
        .required = "required",
    };
};
