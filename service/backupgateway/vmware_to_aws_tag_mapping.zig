/// This displays the mapping of VMware tags to the
/// corresponding Amazon Web Services tags.
pub const VmwareToAwsTagMapping = struct {
    /// The key part of the Amazon Web Services tag's key-value pair.
    aws_tag_key: []const u8,

    /// The value part of the Amazon Web Services tag's key-value pair.
    aws_tag_value: []const u8,

    /// The is the category of VMware.
    vmware_category: []const u8,

    /// This is the user-defined name of a VMware tag.
    vmware_tag_name: []const u8,

    pub const json_field_names = .{
        .aws_tag_key = "AwsTagKey",
        .aws_tag_value = "AwsTagValue",
        .vmware_category = "VmwareCategory",
        .vmware_tag_name = "VmwareTagName",
    };
};
