/// The properties that are applied when Datadog is being used as a source.
pub const DatadogSourceProperties = struct {
    /// The object specified in the Datadog flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
