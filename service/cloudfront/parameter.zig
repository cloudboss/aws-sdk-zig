/// A list of parameter values to add to the resource. A parameter is specified
/// as a key-value pair. A valid parameter value must exist for any parameter
/// that is marked as required in the multi-tenant distribution.
pub const Parameter = struct {
    /// The parameter name.
    name: []const u8,

    /// The parameter value.
    value: []const u8,
};
