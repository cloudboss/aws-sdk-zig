const DukptDerivationType = @import("dukpt_derivation_type.zig").DukptDerivationType;

/// Parameters that are used for Derived Unique Key Per Transaction (DUKPT)
/// derivation algorithm.
pub const DukptAttributes = struct {
    /// The key type derived using DUKPT from a Base Derivation Key (BDK) and Key
    /// Serial Number (KSN). This must be less than or equal to the strength of the
    /// BDK. For example, you can't use `AES_128` as a derivation type for a BDK of
    /// `AES_128` or `TDES_2KEY`.
    dukpt_derivation_type: DukptDerivationType,

    /// The unique identifier known as Key Serial Number (KSN) that comes from an
    /// encrypting device using DUKPT encryption method. The KSN is derived from the
    /// encrypting device unique identifier and an internal transaction counter.
    key_serial_number: []const u8,

    pub const json_field_names = .{
        .dukpt_derivation_type = "DukptDerivationType",
        .key_serial_number = "KeySerialNumber",
    };
};
