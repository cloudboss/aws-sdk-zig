/// The properties that are applied when Marketo is being used as a source.
pub const MarketoSourceProperties = struct {
    /// The object specified in the Marketo flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
