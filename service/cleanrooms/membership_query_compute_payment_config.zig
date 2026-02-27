/// An object representing the payment responsibilities accepted by the
/// collaboration member for query compute costs.
pub const MembershipQueryComputePaymentConfig = struct {
    /// Indicates whether the collaboration member has accepted to pay for query
    /// compute costs (`TRUE`) or has not accepted to pay for query compute costs
    /// (`FALSE`).
    ///
    /// If the collaboration creator has not specified anyone to pay for query
    /// compute costs, then the member who can query is the default payer.
    ///
    /// An error message is returned for the following reasons:
    ///
    /// * If you set the value to `FALSE` but you are responsible to pay for query
    ///   compute costs.
    /// * If you set the value to `TRUE` but you are not responsible to pay for
    ///   query compute costs.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
