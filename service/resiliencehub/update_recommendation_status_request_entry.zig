const ExcludeRecommendationReason = @import("exclude_recommendation_reason.zig").ExcludeRecommendationReason;
const UpdateRecommendationStatusItem = @import("update_recommendation_status_item.zig").UpdateRecommendationStatusItem;

/// Defines the operational recommendation item that is to be included or
/// excluded.
pub const UpdateRecommendationStatusRequestEntry = struct {
    /// Indicates the identifier of the AppComponent.
    app_component_id: ?[]const u8 = null,

    /// An identifier for an entry in this batch that is used to communicate the
    /// result.
    ///
    /// The `entryId`s of a batch request need to be unique within a request.
    entry_id: []const u8,

    /// Indicates if the operational recommendation needs to be excluded. If set to
    /// True, the
    /// operational recommendation will be excluded.
    excluded: bool,

    /// Indicates the reason for excluding an operational recommendation.
    exclude_reason: ?ExcludeRecommendationReason = null,

    /// The operational recommendation item.
    item: ?UpdateRecommendationStatusItem = null,

    /// Reference identifier of the operational recommendation item.
    reference_id: []const u8,

    pub const json_field_names = .{
        .app_component_id = "appComponentId",
        .entry_id = "entryId",
        .excluded = "excluded",
        .exclude_reason = "excludeReason",
        .item = "item",
        .reference_id = "referenceId",
    };
};
