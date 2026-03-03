/// Returns the path to the `ObjectIdentifiers` that is associated with the
/// directory.
pub const PathToObjectIdentifiers = struct {
    /// Lists `ObjectIdentifiers` starting from directory root to the object in the
    /// request.
    object_identifiers: ?[]const []const u8 = null,

    /// The path that is used to identify the object starting from directory root.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifiers = "ObjectIdentifiers",
        .path = "Path",
    };
};
