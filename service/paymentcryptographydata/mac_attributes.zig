const MacAlgorithm = @import("mac_algorithm.zig").MacAlgorithm;
const MacAlgorithmDukpt = @import("mac_algorithm_dukpt.zig").MacAlgorithmDukpt;
const MacAlgorithmEmv = @import("mac_algorithm_emv.zig").MacAlgorithmEmv;

/// Parameters that are required for DUKPT, HMAC, or EMV MAC generation or
/// verification.
pub const MacAttributes = union(enum) {
    /// The encryption algorithm for MAC generation or verification.
    algorithm: ?MacAlgorithm,
    /// Parameters that are required for MAC generation or verification using DUKPT
    /// CMAC algorithm.
    dukpt_cmac: ?MacAlgorithmDukpt,
    /// Parameters that are required for MAC generation or verification using DUKPT
    /// ISO 9797 algorithm1.
    dukpt_iso_9797_algorithm_1: ?MacAlgorithmDukpt,
    /// Parameters that are required for MAC generation or verification using DUKPT
    /// ISO 9797 algorithm3.
    dukpt_iso_9797_algorithm_3: ?MacAlgorithmDukpt,
    /// Parameters that are required for MAC generation or verification using EMV
    /// MAC algorithm.
    emv_mac: ?MacAlgorithmEmv,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .dukpt_cmac = "DukptCmac",
        .dukpt_iso_9797_algorithm_1 = "DukptIso9797Algorithm1",
        .dukpt_iso_9797_algorithm_3 = "DukptIso9797Algorithm3",
        .emv_mac = "EmvMac",
    };
};
