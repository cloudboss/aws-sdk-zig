/// The code review settings for an agent space, controlling which types of
/// scanning are enabled.
pub const CodeReviewSettings = struct {
    /// Indicates whether controls scanning is enabled for code reviews.
    controls_scanning: bool,

    /// Indicates whether general-purpose scanning is enabled for code reviews.
    general_purpose_scanning: bool,

    pub const json_field_names = .{
        .controls_scanning = "controlsScanning",
        .general_purpose_scanning = "generalPurposeScanning",
    };
};
