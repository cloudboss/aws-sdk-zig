/// The set of resources authorized by a permit. Specify either all resources in
/// the Region or a list of specific resources.
pub const ResourceSet = union(enum) {
    /// Authorizes the support operator to act on all resources in the Region.
    all_resources_in_region: ?struct {},
    /// A list of specific resource identifiers that the support operator is
    /// authorized to act upon. Maximum of 5 resources.
    resources: ?[]const []const u8,

    pub const json_field_names = .{
        .all_resources_in_region = "allResourcesInRegion",
        .resources = "resources",
    };
};
