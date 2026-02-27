/// An object representing the collaboration member's model inference payment
/// responsibilities set by the collaboration creator.
pub const MembershipModelInferencePaymentConfig = struct {
    /// Indicates whether the collaboration member has accepted to pay for model
    /// inference costs (`TRUE`) or has not accepted to pay for model inference
    /// costs (`FALSE`).
    ///
    /// If the collaboration creator has not specified anyone to pay for model
    /// inference costs, then the member who can query is the default payer.
    ///
    /// An error message is returned for the following reasons:
    ///
    /// * If you set the value to `FALSE` but you are responsible to pay for model
    ///   inference costs.
    /// * If you set the value to `TRUE` but you are not responsible to pay for
    ///   model inference costs.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
