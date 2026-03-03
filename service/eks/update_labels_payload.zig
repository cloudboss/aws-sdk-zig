const aws = @import("aws");

/// An object representing a Kubernetes `label` change for a managed node
/// group.
pub const UpdateLabelsPayload = struct {
    /// The Kubernetes `labels` to add or update.
    add_or_update_labels: ?[]const aws.map.StringMapEntry = null,

    /// The Kubernetes `labels` to remove.
    remove_labels: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .add_or_update_labels = "addOrUpdateLabels",
        .remove_labels = "removeLabels",
    };
};
