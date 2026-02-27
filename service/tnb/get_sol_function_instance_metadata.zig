/// The metadata of a network function instance.
///
/// A network function instance is a function in a function package .
pub const GetSolFunctionInstanceMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// The date that the resource was last modified.
    last_modified: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
    };
};
