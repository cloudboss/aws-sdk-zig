/// The properties that are applied when ServiceNow is being used as a source.
pub const ServiceNowSourceProperties = struct {
    /// The object specified in the ServiceNow flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "Object",
    };
};
