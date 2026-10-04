const AdSequencingMode = @import("ad_sequencing_mode.zig").AdSequencingMode;

/// The settings that control how MediaTailor processes VAST responses from the
/// ad decision server.
pub const VastResponse = struct {
    /// The ad sequencing mode that controls how MediaTailor handles sequenced and
    /// standalone ads in VAST responses. `FOLLOW_AD_SEQUENCE` inserts sequenced ads
    /// in increasing order for both live and VOD workflows, using standalone ads
    /// only as replacements when a sequenced ad fails.
    /// `FOLLOW_AD_SEQUENCE_ONLY_LIVE` enables ad sequencing for live workflows
    /// only. `FOLLOW_AD_SEQUENCE_ONLY_VOD` enables ad sequencing for VOD workflows
    /// only. `IGNORE_AD_SEQUENCE` inserts ads in the order they appear in the VAST
    /// response, regardless of sequence attributes. The default behavior is
    /// `IGNORE_AD_SEQUENCE`.
    ad_sequencing_mode: ?AdSequencingMode = null,

    pub const json_field_names = .{
        .ad_sequencing_mode = "AdSequencingMode",
    };
};
