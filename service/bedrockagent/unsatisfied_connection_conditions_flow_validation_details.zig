/// Details about unsatisfied conditions for a connection. A condition is
/// unsatisfied if it can never be true, for example two branches of condition
/// node cannot be simultaneously true.
pub const UnsatisfiedConnectionConditionsFlowValidationDetails = struct {
    /// The name of the connection with unsatisfied conditions.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
