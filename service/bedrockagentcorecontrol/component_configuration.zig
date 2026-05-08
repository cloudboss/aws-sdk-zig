/// The configuration for a component within a configuration bundle. The
/// component type is inferred from the component identifier ARN.
pub const ComponentConfiguration = struct {
    /// The configuration values as a flexible JSON document.
    configuration: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};
