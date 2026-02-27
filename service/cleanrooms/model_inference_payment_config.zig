/// An object representing the collaboration member's model inference payment
/// responsibilities set by the collaboration creator.
pub const ModelInferencePaymentConfig = struct {
    /// Indicates whether the collaboration creator has configured the collaboration
    /// member to pay for model inference costs (`TRUE`) or has not configured the
    /// collaboration member to pay for model inference costs (`FALSE`).
    ///
    /// Exactly one member can be configured to pay for model inference costs. An
    /// error is returned if the collaboration creator sets a `TRUE` value for more
    /// than one member in the collaboration.
    ///
    /// If the collaboration creator hasn't specified anyone as the member paying
    /// for model inference costs, then the member who can query is the default
    /// payer. An error is returned if the collaboration creator sets a `FALSE`
    /// value for the member who can query.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
