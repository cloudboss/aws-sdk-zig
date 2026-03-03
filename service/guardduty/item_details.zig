const AdditionalInfo = @import("additional_info.zig").AdditionalInfo;

/// Contains detailed information about where a threat was detected.
pub const ItemDetails = struct {
    /// Additional information about the detected threat item.
    additional_info: ?AdditionalInfo = null,

    /// The hash value of the infected item.
    hash: ?[]const u8 = null,

    /// The path where the threat was detected.
    item_path: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resource where the threat was detected.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_info = "AdditionalInfo",
        .hash = "Hash",
        .item_path = "ItemPath",
        .resource_arn = "ResourceArn",
    };
};
