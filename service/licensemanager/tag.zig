/// Details about the tags for a resource. For more information about tagging
/// support in
/// License Manager, see the
/// [TagResource](https://docs.aws.amazon.com/license-manager/latest/APIReference/API_TagResource.html) operation.
pub const Tag = struct {
    /// The tag key.
    key: ?[]const u8 = null,

    /// The tag value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
