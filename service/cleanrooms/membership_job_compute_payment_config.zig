/// An object representing the payment responsibilities accepted by the
/// collaboration member for query and job compute costs.
pub const MembershipJobComputePaymentConfig = struct {
    /// Indicates whether the collaboration member has accepted to pay for job
    /// compute costs (`TRUE`) or has not accepted to pay for query and job compute
    /// costs (`FALSE`).
    ///
    /// There is only one member who pays for queries and jobs.
    ///
    /// An error message is returned for the following reasons:
    ///
    /// * If you set the value to `FALSE` but you are responsible to pay for query
    ///   and job compute costs.
    /// * If you set the value to `TRUE` but you are not responsible to pay for
    ///   query and job compute costs.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
