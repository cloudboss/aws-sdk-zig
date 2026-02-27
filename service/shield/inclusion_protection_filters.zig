const ProtectedResourceType = @import("protected_resource_type.zig").ProtectedResourceType;

/// Narrows the set of protections that the call retrieves. You can retrieve a
/// single protection by providing its name or the ARN (Amazon Resource Name) of
/// its protected resource. You can also retrieve all protections for a specific
/// resource type. You can provide up to one criteria per filter type. Shield
/// Advanced returns protections that exactly match all of the filter criteria
/// that you provide.
pub const InclusionProtectionFilters = struct {
    /// The name of the protection that you want to retrieve.
    protection_names: ?[]const []const u8,

    /// The ARN (Amazon Resource Name) of the resource whose protection you want to
    /// retrieve.
    resource_arns: ?[]const []const u8,

    /// The type of protected resource whose protections you want to retrieve.
    resource_types: ?[]const ProtectedResourceType,

    pub const json_field_names = .{
        .protection_names = "ProtectionNames",
        .resource_arns = "ResourceArns",
        .resource_types = "ResourceTypes",
    };
};
