/// An object representing the collaboration member's payment responsibilities
/// set by the collaboration creator for query compute costs.
pub const QueryComputePaymentConfig = struct {
    /// Indicates whether the collaboration creator has configured the collaboration
    /// member to pay for query compute costs (`TRUE`) or has not configured the
    /// collaboration member to pay for query compute costs (`FALSE`).
    ///
    /// One or more members can be configured as payer candidates for query compute
    /// costs.
    ///
    /// If the collaboration creator hasn't specified anyone as the member paying
    /// for query compute costs, then the member who can query is the default payer.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
