const X12FunctionalAcknowledgment = @import("x12_functional_acknowledgment.zig").X12FunctionalAcknowledgment;
const X12TechnicalAcknowledgment = @import("x12_technical_acknowledgment.zig").X12TechnicalAcknowledgment;

/// Contains options for configuring X12 acknowledgments. These options control
/// how functional and technical acknowledgments are handled.
pub const X12AcknowledgmentOptions = struct {
    /// Specifies whether functional acknowledgments (997/999) should be generated
    /// for incoming X12 transactions. Valid values are `DO_NOT_GENERATE`,
    /// `GENERATE_ALL_SEGMENTS` and
    /// `GENERATE_WITHOUT_TRANSACTION_SET_RESPONSE_LOOP`.
    ///
    /// If you choose `GENERATE_WITHOUT_TRANSACTION_SET_RESPONSE_LOOP`, Amazon Web
    /// Services B2B Data Interchange skips the AK2_Loop when generating an
    /// acknowledgment document.
    functional_acknowledgment: X12FunctionalAcknowledgment,

    /// Specifies whether technical acknowledgments (TA1) should be generated for
    /// incoming X12 interchanges. Valid values are `DO_NOT_GENERATE` and
    /// `GENERATE_ALL_SEGMENTS` and.
    technical_acknowledgment: X12TechnicalAcknowledgment,

    pub const json_field_names = .{
        .functional_acknowledgment = "functionalAcknowledgment",
        .technical_acknowledgment = "technicalAcknowledgment",
    };
};
