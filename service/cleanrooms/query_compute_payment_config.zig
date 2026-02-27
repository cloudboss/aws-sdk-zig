/// An object representing the collaboration member's payment responsibilities
/// set by the collaboration creator for query compute costs.
pub const QueryComputePaymentConfig = struct {
    /// Indicates whether the collaboration creator has configured the collaboration
    /// member to pay for query compute costs (`TRUE`) or has not configured the
    /// collaboration member to pay for query compute costs (`FALSE`).
    ///
    /// Exactly one member can be configured to pay for query compute costs. An
    /// error is returned if the collaboration creator sets a `TRUE` value for more
    /// than one member in the collaboration.
    ///
    /// If the collaboration creator hasn't specified anyone as the member paying
    /// for query compute costs, then the member who can query is the default payer.
    /// An error is returned if the collaboration creator sets a `FALSE` value for
    /// the member who can query.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
