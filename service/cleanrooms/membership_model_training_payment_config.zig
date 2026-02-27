/// An object representing the collaboration member's model training payment
/// responsibilities set by the collaboration creator.
pub const MembershipModelTrainingPaymentConfig = struct {
    /// Indicates whether the collaboration member has accepted to pay for model
    /// training costs (`TRUE`) or has not accepted to pay for model training costs
    /// (`FALSE`).
    ///
    /// If the collaboration creator has not specified anyone to pay for model
    /// training costs, then the member who can query is the default payer.
    ///
    /// An error message is returned for the following reasons:
    ///
    /// * If you set the value to `FALSE` but you are responsible to pay for model
    ///   training costs.
    /// * If you set the value to `TRUE` but you are not responsible to pay for
    ///   model training costs.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
