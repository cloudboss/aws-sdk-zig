const ConflictResolvingModel = @import("conflict_resolving_model.zig").ConflictResolvingModel;

/// How the auto-merging process should resolve conflicts between different
/// profiles.
pub const ConflictResolution = struct {
    /// How the auto-merging process should resolve conflicts between different
    /// profiles.
    ///
    /// * `RECENCY`: Uses the data that was most recently updated.
    ///
    /// * `SOURCE`: Uses the data from a specific source. For example, if a
    /// company has been aquired or two departments have merged, data from the
    /// specified
    /// source is used. If two duplicate profiles are from the same source, then
    /// `RECENCY` is used again.
    conflict_resolving_model: ConflictResolvingModel,

    /// The `ObjectType` name that is used to resolve profile merging conflicts when
    /// choosing `SOURCE` as the `ConflictResolvingModel`.
    source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .conflict_resolving_model = "ConflictResolvingModel",
        .source_name = "SourceName",
    };
};
