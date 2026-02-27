/// The schema definition for tool input parameters.
pub const ToolInputSchema = union(enum) {
    /// The JSON schema that defines the expected input format for the tool.
    json: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
    };
};
