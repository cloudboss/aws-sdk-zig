/// This data type is used as a request parameter in the AddAttributesToFindings
/// and CreateAssessmentTemplate
/// actions.
pub const Attribute = struct {
    /// The attribute key.
    key: []const u8,

    /// The value assigned to the attribute key.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
