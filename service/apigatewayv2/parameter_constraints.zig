/// Validation constraints imposed on parameters of a request (path, query
/// string, headers).
pub const ParameterConstraints = struct {
    /// Whether or not the parameter is required.
    required: ?bool,

    pub const json_field_names = .{
        .required = "Required",
    };
};
