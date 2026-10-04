/// An object representing the collaboration member's model inference payment
/// responsibilities set by the collaboration creator.
pub const ModelInferencePaymentConfig = struct {
    /// Indicates whether the collaboration creator has configured the collaboration
    /// member to pay for model inference costs (`TRUE`) or has not configured the
    /// collaboration member to pay for model inference costs (`FALSE`).
    ///
    /// One or more members can be configured as payer candidates for model
    /// inference costs.
    ///
    /// If the collaboration creator hasn't specified anyone as the member paying
    /// for model inference costs, then the member who can query is the default
    /// payer.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
