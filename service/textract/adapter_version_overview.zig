const FeatureType = @import("feature_type.zig").FeatureType;
const AdapterVersionStatus = @import("adapter_version_status.zig").AdapterVersionStatus;

/// Summary info for an adapter version. Contains information on the AdapterId,
/// AdapterVersion, CreationTime, FeatureTypes, and Status.
pub const AdapterVersionOverview = struct {
    /// A unique identifier for the adapter associated with a given adapter version.
    adapter_id: ?[]const u8,

    /// An identified for a given adapter version.
    adapter_version: ?[]const u8,

    /// The date and time that a given adapter version was created.
    creation_time: ?i64,

    /// The feature types that the adapter version is operating on.
    feature_types: ?[]const FeatureType,

    /// Contains information on the status of a given adapter version.
    status: ?AdapterVersionStatus,

    /// A message explaining the status of a given adapter vesion.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_version = "AdapterVersion",
        .creation_time = "CreationTime",
        .feature_types = "FeatureTypes",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
