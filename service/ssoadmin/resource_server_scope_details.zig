/// A structure that describes details for an IAM Identity Center access scope
/// that is associated with a resource server.
pub const ResourceServerScopeDetails = struct {
    /// The title of an access scope for a resource server.
    detailed_title: ?[]const u8,

    /// The description of an access scope for a resource server.
    long_description: ?[]const u8,

    pub const json_field_names = .{
        .detailed_title = "DetailedTitle",
        .long_description = "LongDescription",
    };
};
