const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const Consolidation = @import("consolidation.zig").Consolidation;

/// Configuration settings for how to perform the auto-merging of profiles.
pub const AutoMerging = struct {
    /// How the auto-merging process should resolve conflicts between different
    /// profiles. For
    /// example, if Profile A and Profile B have the same `FirstName` and
    /// `LastName` (and that is the matching criteria), which
    /// `EmailAddress` should be used?
    conflict_resolution: ?ConflictResolution = null,

    /// A list of matching attributes that represent matching criteria. If two
    /// profiles meet at
    /// least one of the requirements in the matching attributes list, they will be
    /// merged.
    consolidation: ?Consolidation = null,

    /// The flag that enables the auto-merging of duplicate profiles.
    enabled: bool,

    /// A number between 0 and 1 that represents the minimum confidence score
    /// required for
    /// profiles within a matching group to be merged during the auto-merge process.
    /// A higher score
    /// means higher similarity required to merge profiles.
    min_allowed_confidence_score_for_merging: ?f64 = null,

    pub const json_field_names = .{
        .conflict_resolution = "ConflictResolution",
        .consolidation = "Consolidation",
        .enabled = "Enabled",
        .min_allowed_confidence_score_for_merging = "MinAllowedConfidenceScoreForMerging",
    };
};
