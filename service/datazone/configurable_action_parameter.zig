/// The details of the parameters for the configurable environment action.
pub const ConfigurableActionParameter = struct {
    /// The key of the configurable action parameter.
    key: ?[]const u8,

    /// The value of the configurable action parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
