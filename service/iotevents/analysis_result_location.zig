/// Contains information that you can use to locate the field in your detector
/// model that the
/// analysis result references.
pub const AnalysisResultLocation = struct {
    /// A [JsonPath](https://github.com/json-path/JsonPath) expression that
    /// identifies the error field in your detector model.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .path = "path",
    };
};
