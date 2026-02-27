/// Details about the step associated with a finding.
pub const Step = struct {
    /// The component ARN. The ARN can be null and is not displayed in the Amazon
    /// Web Services
    /// console.
    component_arn: ?[]const u8,

    /// The component ID.
    component_id: []const u8,

    /// The component type.
    component_type: []const u8,

    pub const json_field_names = .{
        .component_arn = "componentArn",
        .component_id = "componentId",
        .component_type = "componentType",
    };
};
