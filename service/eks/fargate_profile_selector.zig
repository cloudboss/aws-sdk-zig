const aws = @import("aws");

/// An object representing an Fargate profile selector.
pub const FargateProfileSelector = struct {
    /// The Kubernetes labels that the selector should match. A pod must contain all
    /// of the labels
    /// that are specified in the selector for it to be considered a match.
    labels: ?[]const aws.map.StringMapEntry,

    /// The Kubernetes `namespace` that the selector should match.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .labels = "labels",
        .namespace = "namespace",
    };
};
