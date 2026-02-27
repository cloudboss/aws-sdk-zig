/// The properties that are applied when using Trend Micro as a flow source.
pub const TrendmicroSourceProperties = struct {
    /// The object specified in the Trend Micro flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
