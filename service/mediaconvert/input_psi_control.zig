/// Set PSI control for transport stream inputs to specify which data the demux
/// process to scans.
/// * Ignore PSI - Scan all PIDs for audio and video.
/// * Use PSI - Scan only PSI data.
pub const InputPsiControl = enum {
    ignore_psi,
    use_psi,

    pub const json_field_names = .{
        .ignore_psi = "IGNORE_PSI",
        .use_psi = "USE_PSI",
    };
};
