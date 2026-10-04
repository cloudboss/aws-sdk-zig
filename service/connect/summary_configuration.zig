const SummaryMode = @import("summary_mode.zig").SummaryMode;

/// The summary configuration for conversational analytics.
pub const SummaryConfiguration = struct {
    /// The summary modes that determine what type of summarization is generated.
    /// Valid values:
    /// `PostContact` | `AutomatedInteraction` | `ContactChain`.
    summary_modes: []const SummaryMode,

    pub const json_field_names = .{
        .summary_modes = "SummaryModes",
    };
};
