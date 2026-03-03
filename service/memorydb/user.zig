const Authentication = @import("authentication.zig").Authentication;

/// You create users and assign them specific permissions by using an access
/// string. You assign the users to Access Control Lists aligned with a specific
/// role (administrators, human resources) that are then deployed to one or more
/// MemoryDB clusters.
pub const User = struct {
    /// Access permissions string used for this user.
    access_string: ?[]const u8 = null,

    /// The names of the Access Control Lists to which the user belongs
    acl_names: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the user.
    arn: ?[]const u8 = null,

    /// Denotes whether the user requires a password to authenticate.
    authentication: ?Authentication = null,

    /// The minimum engine version supported for the user
    minimum_engine_version: ?[]const u8 = null,

    /// The name of the user
    name: ?[]const u8 = null,

    /// Indicates the user status. Can be "active", "modifying" or "deleting".
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_string = "AccessString",
        .acl_names = "ACLNames",
        .arn = "ARN",
        .authentication = "Authentication",
        .minimum_engine_version = "MinimumEngineVersion",
        .name = "Name",
        .status = "Status",
    };
};
