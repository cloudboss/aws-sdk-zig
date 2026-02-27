/// The properties that are applied when Salesforce Pardot is being used as a
/// source.
pub const PardotSourceProperties = struct {
    /// The object specified in the Salesforce Pardot flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
