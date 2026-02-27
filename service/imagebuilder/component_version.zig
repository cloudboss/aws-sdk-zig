const Platform = @import("platform.zig").Platform;
const ProductCodeListItem = @import("product_code_list_item.zig").ProductCodeListItem;
const ComponentStatus = @import("component_status.zig").ComponentStatus;
const ComponentType = @import("component_type.zig").ComponentType;

/// The defining characteristics of a specific version of an Amazon Web Services
/// TOE component.
pub const ComponentVersion = struct {
    /// The Amazon Resource Name (ARN) of the component.
    ///
    /// Semantic versioning is included in each object's Amazon Resource Name (ARN),
    /// at the level that applies to that object as follows:
    ///
    /// * Versionless ARNs and Name ARNs do not include specific values in any of
    ///   the nodes. The nodes are
    /// either left off entirely, or they are specified as wildcards, for example:
    /// x.x.x.
    ///
    /// * Version ARNs have only the first three nodes: ..
    ///
    /// * Build version ARNs have all four nodes, and point to a specific build for
    ///   a specific version of an object.
    arn: ?[]const u8,

    /// The date that the component was created.
    date_created: ?[]const u8,

    /// The description of the component.
    description: ?[]const u8,

    /// The name of the component.
    name: ?[]const u8,

    /// The owner of the component.
    owner: ?[]const u8,

    /// The platform of the component.
    platform: ?Platform,

    /// Contains product codes that are used for billing purposes for Amazon Web
    /// Services Marketplace components.
    product_codes: ?[]const ProductCodeListItem,

    /// Describes the current status of the component version.
    status: ?ComponentStatus,

    /// he operating system (OS) version supported by the component. If the OS
    /// information is
    /// available, a prefix match is performed against the base image OS version
    /// during image
    /// recipe creation.
    supported_os_versions: ?[]const []const u8,

    /// The type of the component denotes whether the component is used to build the
    /// image or
    /// only to test it.
    type: ?ComponentType,

    /// The semantic version of the component.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Assignment:** For the first three nodes you can assign any positive
    /// integer value, including
    /// zero, with an upper limit of 2^30-1, or 1073741823 for each node. Image
    /// Builder automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    ///
    /// **Filtering:** With semantic versioning, you have the flexibility to use
    /// wildcards (x)
    /// to specify the most recent versions or nodes when selecting the base image
    /// or components for your
    /// recipe. When you use a wildcard in any node, all nodes to the right of the
    /// first wildcard must also be
    /// wildcards.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .description = "description",
        .name = "name",
        .owner = "owner",
        .platform = "platform",
        .product_codes = "productCodes",
        .status = "status",
        .supported_os_versions = "supportedOsVersions",
        .type = "type",
        .version = "version",
    };
};
