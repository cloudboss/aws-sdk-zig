const aws = @import("aws");

/// A key-value pair you set that identifies a property of the authenticating
/// instance.
pub const InstanceProperty = struct {
    /// Indicates whether the temporary credential request was successful.
    failed: ?bool = null,

    /// A list of instanceProperty objects.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The ISO-8601 time stamp of when the certificate was last used in a temporary
    /// credential request.
    seen_at: ?i64 = null,

    pub const json_field_names = .{
        .failed = "failed",
        .properties = "properties",
        .seen_at = "seenAt",
    };
};
