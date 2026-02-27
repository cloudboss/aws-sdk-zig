/// Returns the kind of currency detected.
pub const ExpenseCurrency = struct {
    /// Currency code for detected currency. the current supported codes are:
    ///
    /// * USD
    ///
    /// * EUR
    ///
    /// * GBP
    ///
    /// * CAD
    ///
    /// * INR
    ///
    /// * JPY
    ///
    /// * CHF
    ///
    /// * AUD
    ///
    /// * CNY
    ///
    /// * BZR
    ///
    /// * SEK
    ///
    /// * HKD
    code: ?[]const u8,

    /// Percentage confideence in the detected currency.
    confidence: ?f32,

    pub const json_field_names = .{
        .code = "Code",
        .confidence = "Confidence",
    };
};
