/// Specifies one or more attributes to remove from all the endpoints that are
/// associated with an application.
pub const UpdateAttributesRequest = struct {
    /// An array of the attributes to remove from all the endpoints that are
    /// associated with the application. The array can specify the complete, exact
    /// name of each attribute to remove or it can specify a glob pattern that an
    /// attribute name must match in order for the attribute to be removed.
    blacklist: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .blacklist = "Blacklist",
    };
};
