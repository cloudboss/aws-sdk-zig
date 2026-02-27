const ParameterType = @import("parameter_type.zig").ParameterType;

/// Optional. The member who can query can provide this placeholder for a
/// literal data value in an analysis template.
pub const AnalysisParameter = struct {
    /// Optional. The default value that is applied in the analysis template. The
    /// member who can query can override this value in the query editor.
    default_value: ?[]const u8,

    /// The name of the parameter. The name must use only alphanumeric or underscore
    /// (_) characters.
    name: []const u8,

    /// The type of parameter.
    @"type": ParameterType,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .name = "name",
        .@"type" = "type",
    };
};
