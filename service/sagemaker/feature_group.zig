const FeatureDefinition = @import("feature_definition.zig").FeatureDefinition;
const FeatureGroupStatus = @import("feature_group_status.zig").FeatureGroupStatus;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const OfflineStoreConfig = @import("offline_store_config.zig").OfflineStoreConfig;
const OfflineStoreStatus = @import("offline_store_status.zig").OfflineStoreStatus;
const OnlineStoreConfig = @import("online_store_config.zig").OnlineStoreConfig;
const Tag = @import("tag.zig").Tag;

/// Amazon SageMaker Feature Store stores features in a collection called
/// Feature Group. A Feature Group can be visualized as a table which has rows,
/// with a unique identifier for each row where each column in the table is a
/// feature. In principle, a Feature Group is composed of features and values
/// per features.
pub const FeatureGroup = struct {
    /// The time a `FeatureGroup` was created.
    creation_time: ?i64,

    /// A free form description of a `FeatureGroup`.
    description: ?[]const u8,

    /// The name of the feature that stores the `EventTime` of a Record in a
    /// `FeatureGroup`.
    ///
    /// A `EventTime` is point in time when a new event occurs that corresponds to
    /// the creation or update of a `Record` in `FeatureGroup`. All `Records` in the
    /// `FeatureGroup` must have a corresponding `EventTime`.
    event_time_feature_name: ?[]const u8,

    /// The reason that the `FeatureGroup` failed to be replicated in the
    /// `OfflineStore`. This is failure may be due to a failure to create a
    /// `FeatureGroup` in or delete a `FeatureGroup` from the `OfflineStore`.
    failure_reason: ?[]const u8,

    /// A list of `Feature`s. Each `Feature` must include a `FeatureName` and a
    /// `FeatureType`.
    ///
    /// Valid `FeatureType`s are `Integral`, `Fractional` and `String`.
    ///
    /// `FeatureName`s cannot be any of the following: `is_deleted`, `write_time`,
    /// `api_invocation_time`.
    ///
    /// You can create up to 2,500 `FeatureDefinition`s per `FeatureGroup`.
    feature_definitions: ?[]const FeatureDefinition,

    /// The Amazon Resource Name (ARN) of a `FeatureGroup`.
    feature_group_arn: ?[]const u8,

    /// The name of the `FeatureGroup`.
    feature_group_name: ?[]const u8,

    /// A `FeatureGroup` status.
    feature_group_status: ?FeatureGroupStatus,

    /// A timestamp indicating the last time you updated the feature group.
    last_modified_time: ?i64,

    /// A value that indicates whether the feature group was updated successfully.
    last_update_status: ?LastUpdateStatus,

    offline_store_config: ?OfflineStoreConfig,

    offline_store_status: ?OfflineStoreStatus,

    online_store_config: ?OnlineStoreConfig,

    /// The name of the `Feature` whose value uniquely identifies a `Record` defined
    /// in the `FeatureGroup` `FeatureDefinitions`.
    record_identifier_feature_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM execution role used to create the
    /// feature group.
    role_arn: ?[]const u8,

    /// Tags used to define a `FeatureGroup`.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .event_time_feature_name = "EventTimeFeatureName",
        .failure_reason = "FailureReason",
        .feature_definitions = "FeatureDefinitions",
        .feature_group_arn = "FeatureGroupArn",
        .feature_group_name = "FeatureGroupName",
        .feature_group_status = "FeatureGroupStatus",
        .last_modified_time = "LastModifiedTime",
        .last_update_status = "LastUpdateStatus",
        .offline_store_config = "OfflineStoreConfig",
        .offline_store_status = "OfflineStoreStatus",
        .online_store_config = "OnlineStoreConfig",
        .record_identifier_feature_name = "RecordIdentifierFeatureName",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};
