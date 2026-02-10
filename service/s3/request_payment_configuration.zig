const Payer = @import("payer.zig").Payer;

/// Container for Payer.
pub const RequestPaymentConfiguration = struct {
    /// Specifies who pays for the download and request fees.
    payer: Payer,
};
