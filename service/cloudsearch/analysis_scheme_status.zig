const AnalysisScheme = @import("analysis_scheme.zig").AnalysisScheme;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status and configuration of an `AnalysisScheme`.
pub const AnalysisSchemeStatus = struct {
    options: AnalysisScheme,

    status: OptionStatus,
};
