/// Input parameters in the form of key-value pairs for the conformance pack,
/// both of which you define.
/// Keys can have a maximum character length of 255 characters, and values can
/// have a maximum length of 4096 characters.
pub const ConformancePackInputParameter = struct {
    /// One part of a key-value pair.
    parameter_name: []const u8,

    /// Another part of the key-value pair.
    parameter_value: []const u8,

    pub const json_field_names = .{
        .parameter_name = "ParameterName",
        .parameter_value = "ParameterValue",
    };
};
