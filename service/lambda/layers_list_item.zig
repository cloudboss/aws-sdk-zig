const LayerVersionsListItem = @import("layer_versions_list_item.zig").LayerVersionsListItem;

/// Details about an [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
pub const LayersListItem = struct {
    /// The newest version of the layer.
    latest_matching_version: ?LayerVersionsListItem,

    /// The Amazon Resource Name (ARN) of the function layer.
    layer_arn: ?[]const u8,

    /// The name of the layer.
    layer_name: ?[]const u8,
};
