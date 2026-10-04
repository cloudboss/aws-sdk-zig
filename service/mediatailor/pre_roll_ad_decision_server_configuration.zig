const PreRollVastResponse = @import("pre_roll_vast_response.zig").PreRollVastResponse;

/// The ad decision server configuration for live pre-roll ads. It contains
/// settings that control how MediaTailor processes VAST responses for pre-roll
/// ad breaks.
pub const PreRollAdDecisionServerConfiguration = struct {
    /// The settings that control how MediaTailor processes VAST responses for live
    /// pre-roll ad breaks.
    vast_response: ?PreRollVastResponse = null,

    pub const json_field_names = .{
        .vast_response = "VastResponse",
    };
};
