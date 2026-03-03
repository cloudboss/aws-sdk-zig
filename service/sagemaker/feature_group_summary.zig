const FeatureGroupStatus = @import("feature_group_status.zig").FeatureGroupStatus;
const OfflineStoreStatus = @import("offline_store_status.zig").OfflineStoreStatus;

/// The name, ARN, `CreationTime`, `FeatureGroup` values, `LastUpdatedTime` and
/// `EnableOnlineStorage` status of a `FeatureGroup`.
pub const FeatureGroupSummary = struct {
    /// A timestamp indicating the time of creation time of the `FeatureGroup`.
    creation_time: i64,

    /// Unique identifier for the `FeatureGroup`.
    feature_group_arn: []const u8,

    /// The name of `FeatureGroup`.
    feature_group_name: []const u8,

    /// The status of a FeatureGroup. The status can be any of the following:
    /// `Creating`, `Created`, `CreateFail`, `Deleting` or `DetailFail`.
    feature_group_status: ?FeatureGroupStatus = null,

    /// Notifies you if replicating data into the `OfflineStore` has failed. Returns
    /// either: `Active` or `Blocked`.
    offline_store_status: ?OfflineStoreStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .feature_group_arn = "FeatureGroupArn",
        .feature_group_name = "FeatureGroupName",
        .feature_group_status = "FeatureGroupStatus",
        .offline_store_status = "OfflineStoreStatus",
    };
};
