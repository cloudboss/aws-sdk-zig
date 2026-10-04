const FeatureValue = @import("feature_value.zig").FeatureValue;
const TargetStore = @import("target_store.zig").TargetStore;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

/// An entry to write as part of a `BatchWriteRecord` request.
pub const BatchWriteRecordEntry = struct {
    /// The name or Amazon Resource Name (ARN) of the `FeatureGroup` to write the
    /// record to.
    feature_group_name: []const u8,

    /// List of FeatureValues to be inserted. This will be a full over-write.
    record: []const FeatureValue,

    /// A list of stores to which you're adding the record. By default, Feature
    /// Store adds the
    /// record to all of the stores that you're using for the
    /// `FeatureGroup`.
    target_stores: ?[]const TargetStore = null,

    /// Time to live duration for this entry, where the record is hard deleted after
    /// the
    /// expiration time is reached; `ExpiresAt` = `EventTime` +
    /// `TtlDuration`. This overrides the request level
    /// `TtlDuration`.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .record = "Record",
        .target_stores = "TargetStores",
        .ttl_duration = "TtlDuration",
    };
};
