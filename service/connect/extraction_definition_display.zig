/// The display configuration for an extraction definition.
pub const ExtractionDefinitionDisplay = struct {
    /// The label displayed in the agent workspace for this extraction definition.
    label: ?[]const u8 = null,

    pub const json_field_names = .{
        .label = "Label",
    };
};
