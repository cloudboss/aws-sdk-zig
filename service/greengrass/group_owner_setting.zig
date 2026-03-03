/// Group owner related settings for local resources.
pub const GroupOwnerSetting = struct {
    /// If true, AWS IoT Greengrass automatically adds the specified Linux OS group
    /// owner of the resource to the Lambda process privileges. Thus the Lambda
    /// process will have the file access permissions of the added Linux group.
    auto_add_group_owner: ?bool = null,

    /// The name of the Linux OS group whose privileges will be added to the Lambda
    /// process. This field is optional.
    group_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_add_group_owner = "AutoAddGroupOwner",
        .group_owner = "GroupOwner",
    };
};
