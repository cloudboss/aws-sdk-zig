/// Configuration that defines how BETWEEN range filter operations are
/// translated into REST API request parameters.
pub const BetweenConfiguration = struct {
    /// The parameter name used for the upper bound value in a BETWEEN filter
    /// operation.
    high_bound_key: ?[]const u8 = null,

    /// The parameter name used for the lower bound value in a BETWEEN filter
    /// operation.
    low_bound_key: ?[]const u8 = null,

    /// A template string for constructing the BETWEEN filter expression.
    template: ?[]const u8 = null,

    pub const json_field_names = .{
        .high_bound_key = "HighBoundKey",
        .low_bound_key = "LowBoundKey",
        .template = "Template",
    };
};
