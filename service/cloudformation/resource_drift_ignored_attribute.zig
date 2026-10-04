const DriftIgnoredReason = @import("drift_ignored_reason.zig").DriftIgnoredReason;

/// The `ResourceDriftIgnoredAttribute` data type.
pub const ResourceDriftIgnoredAttribute = struct {
    /// Path of the resource attribute for which drift was ignored.
    path: ?[]const u8 = null,

    /// Reason why drift was ignored for the attribute, can have 3 possible values:
    ///
    /// * `WRITE_ONLY_PROPERTY` – Property is not included in read response for the
    /// resource’s live state.
    ///
    /// * `MANAGED_BY_AWS` – Property is managed by an Amazon Web Services service
    ///   and is expected to be
    /// dynamically modified.
    ///
    /// * `SENSITIVE_PROPERTY` – Property has a sensitive value, such as an Amazon
    ///   Web Services Secrets Manager value.
    reason: ?DriftIgnoredReason = null,
};
