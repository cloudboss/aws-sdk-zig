const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A structure returned by the ListGroupResources operation that
/// contains identity and group membership status information for one of the
/// resources in
/// the group.
pub const ListGroupResourcesItem = struct {
    identifier: ?ResourceIdentifier,

    /// A structure that contains the status of this resource's membership in the
    /// group.
    ///
    /// This field is present in the response only if the group is of type
    /// `AWS::EC2::HostManagement`.
    status: ?ResourceStatus,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .status = "Status",
    };
};
