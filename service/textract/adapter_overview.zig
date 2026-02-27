const FeatureType = @import("feature_type.zig").FeatureType;

/// Contains information on the adapter, including the adapter ID, Name,
/// Creation time, and feature types.
pub const AdapterOverview = struct {
    /// A unique identifier for the adapter resource.
    adapter_id: ?[]const u8,

    /// A string naming the adapter resource.
    adapter_name: ?[]const u8,

    /// The date and time that the adapter was created.
    creation_time: ?i64,

    /// The feature types that the adapter is operating on.
    feature_types: ?[]const FeatureType,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_name = "AdapterName",
        .creation_time = "CreationTime",
        .feature_types = "FeatureTypes",
    };
};
