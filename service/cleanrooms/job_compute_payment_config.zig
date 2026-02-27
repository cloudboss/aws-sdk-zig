/// An object representing the collaboration member's payment responsibilities
/// set by the collaboration creator for query and job compute costs.
pub const JobComputePaymentConfig = struct {
    /// Indicates whether the collaboration creator has configured the collaboration
    /// member to pay for query and job compute costs (`TRUE`) or has not configured
    /// the collaboration member to pay for query and job compute costs (`FALSE`).
    ///
    /// Exactly one member can be configured to pay for query and job compute costs.
    /// An error is returned if the collaboration creator sets a `TRUE` value for
    /// more than one member in the collaboration.
    ///
    /// An error is returned if the collaboration creator sets a `FALSE` value for
    /// the member who can run queries and jobs.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
