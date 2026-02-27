/// Parameter information for IPEK generation during export.
pub const ExportDukptInitialKey = struct {
    /// The KSN for IPEK generation using DUKPT.
    ///
    /// KSN must be padded before sending to Amazon Web Services Payment
    /// Cryptography. KSN hex length should be 20 for a TDES_2KEY key or 24 for an
    /// AES key.
    key_serial_number: []const u8,

    pub const json_field_names = .{
        .key_serial_number = "KeySerialNumber",
    };
};
