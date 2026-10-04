const ExpectedContractDurationTerm = @import("expected_contract_duration_term.zig").ExpectedContractDurationTerm;

/// The expected duration of a partner's contract with the customer. Used to
/// convert Total Contract Value (TCV) to Monthly Recurring Revenue (MRR) for
/// opportunity dealsizing calculations.
pub const ExpectedContractDuration = struct {
    /// The unit of measurement for the contract duration value. Currently accepts
    /// only `Months`.
    term: ExpectedContractDurationTerm,

    /// A String representation of the contract duration as an integer, expressed in
    /// the unit defined by `Term`. Valid values range from `1` to `144`.
    value: []const u8,

    pub const json_field_names = .{
        .term = "Term",
        .value = "Value",
    };
};
