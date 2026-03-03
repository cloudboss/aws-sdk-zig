const aws = @import("aws");

/// A resource group that contains Amazon Web Services resources. You can assign
/// resources to the group
/// by associating either of the following elements with the group:
///
/// * ResourceQuery - Use a resource query to specify a set of tag
/// keys and values. All resources in the same Amazon Web Services Region and
/// Amazon Web Services account that
/// have those keys with the same values are included in the group. You can add
/// a
/// resource query when you create the group, or later by using the
/// PutGroupConfiguration operation.
///
/// * GroupConfiguration - Use a service configuration to
/// associate the group with an Amazon Web Services service. The configuration
/// specifies which
/// resource types can be included in the group.
pub const Group = struct {
    /// A tag that defines the application group membership. This tag is only
    /// supported
    /// for application groups.
    application_tag: ?[]const aws.map.StringMapEntry = null,

    /// The critical rank of the application group on a scale of 1 to 10, with a
    /// rank of 1 being the most critical, and a rank of 10 being least critical.
    criticality: ?i32 = null,

    /// The description of the resource group.
    description: ?[]const u8 = null,

    /// The name of the application group, which you can change at any time.
    display_name: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the resource group.
    group_arn: []const u8,

    /// The name of the resource group.
    name: []const u8,

    /// A name, email address or other identifier for the person or group
    /// who is considered as the owner of this application group within your
    /// organization.
    owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_tag = "ApplicationTag",
        .criticality = "Criticality",
        .description = "Description",
        .display_name = "DisplayName",
        .group_arn = "GroupArn",
        .name = "Name",
        .owner = "Owner",
    };
};
