/// A VMware tag is a tag attached to a specific virtual machine.
/// A
/// [tag](https://docs.aws.amazon.com/aws-backup/latest/devguide/API_BGW_Tag.html)
/// is a key-value pair you can use to manage, filter, and search for your
/// resources.
///
/// The content of VMware tags can be matched to Amazon Web Services tags.
pub const VmwareTag = struct {
    /// The is the category of VMware.
    vmware_category: ?[]const u8 = null,

    /// This is a user-defined description of a VMware tag.
    vmware_tag_description: ?[]const u8 = null,

    /// This is the user-defined name of a VMware tag.
    vmware_tag_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .vmware_category = "VmwareCategory",
        .vmware_tag_description = "VmwareTagDescription",
        .vmware_tag_name = "VmwareTagName",
    };
};
