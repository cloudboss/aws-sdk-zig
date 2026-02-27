/// Lists network function instance metadata.
///
/// A network function instance is a function in a function package .
pub const ListSolFunctionInstanceMetadata = struct {
    /// When the network function instance was created.
    created_at: i64,

    /// When the network function instance was last modified.
    last_modified: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
    };
};
