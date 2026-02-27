/// The unique identifiers for a resource group.
pub const GroupIdentifier = struct {
    /// The critical rank of the application group on a scale of 1 to 10, with a
    /// rank of 1 being the most critical, and a rank of 10 being least critical.
    criticality: ?i32,

    /// The description of the application group.
    description: ?[]const u8,

    /// The name of the application group, which you can change at any time.
    display_name: ?[]const u8,

    /// The Amazon resource name (ARN) of the resource group.
    group_arn: ?[]const u8,

    /// The name of the resource group.
    group_name: ?[]const u8,

    /// A name, email address or other identifier for the person or group
    /// who is considered as the owner of this group within your organization.
    owner: ?[]const u8,

    pub const json_field_names = .{
        .criticality = "Criticality",
        .description = "Description",
        .display_name = "DisplayName",
        .group_arn = "GroupArn",
        .group_name = "GroupName",
        .owner = "Owner",
    };
};
