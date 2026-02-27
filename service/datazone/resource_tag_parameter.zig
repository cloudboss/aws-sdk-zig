/// The resource tag parameter of the project profile.
pub const ResourceTagParameter = struct {
    /// Specifies whether the value of the resource tag parameter of the project
    /// profile is editable at the project level.
    is_value_editable: bool,

    /// The key of the resource tag parameter of the project profile.
    key: []const u8,

    /// The value of the resource tag parameter key of the project profile.
    value: []const u8,

    pub const json_field_names = .{
        .is_value_editable = "isValueEditable",
        .key = "key",
        .value = "value",
    };
};
