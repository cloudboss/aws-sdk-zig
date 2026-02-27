/// The properties that are applied when Dynatrace is being used as a source.
pub const DynatraceSourceProperties = struct {
    /// The object specified in the Dynatrace flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
