/// The attributes from the JSON payload that are made available by the input.
/// Inputs are
/// derived from messages sent to the AWS IoT Events system using
/// `BatchPutMessage`. Each such
/// message contains a JSON payload. Those attributes (and their paired values)
/// specified here are
/// available for use in the `condition` expressions used by detectors.
pub const Attribute = struct {
    /// An expression that specifies an attribute-value pair in a JSON structure.
    /// Use this to
    /// specify an attribute from the JSON payload that is made available by the
    /// input. Inputs are
    /// derived from messages sent to AWS IoT Events (`BatchPutMessage`). Each such
    /// message contains
    /// a JSON payload. The attribute (and its paired value) specified here are
    /// available for use in
    /// the `condition` expressions used by detectors.
    ///
    /// Syntax: `....`
    json_path: []const u8,

    pub const json_field_names = .{
        .json_path = "jsonPath",
    };
};
