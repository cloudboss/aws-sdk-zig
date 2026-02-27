pub const BadRequestReason = enum {
    /// Indicates there was a problem with one or more of the parameters.
    /// See InvalidParameters in the BadRequestDetails for more information.
    invalid_parameters,

    pub const json_field_names = .{
        .invalid_parameters = "INVALID_PARAMETERS",
    };
};
