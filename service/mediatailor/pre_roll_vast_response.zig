const PreRollAdSequencingMode = @import("pre_roll_ad_sequencing_mode.zig").PreRollAdSequencingMode;

/// The settings that control how MediaTailor processes VAST responses from the
/// ad decision server for live pre-roll ad breaks.
pub const PreRollVastResponse = struct {
    /// The ad sequencing mode for live pre-roll ads. `FOLLOW_AD_SEQUENCE` inserts
    /// sequenced ads in increasing order and uses standalone ads only as
    /// replacements when a sequenced ad fails. `IGNORE_AD_SEQUENCE` inserts ads in
    /// the order they appear in the VAST response, regardless of sequence
    /// attributes. The default behavior is `IGNORE_AD_SEQUENCE`.
    ad_sequencing_mode: ?PreRollAdSequencingMode = null,

    pub const json_field_names = .{
        .ad_sequencing_mode = "AdSequencingMode",
    };
};
