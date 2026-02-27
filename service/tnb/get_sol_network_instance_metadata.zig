/// The metadata of a network instance.
///
/// A network instance is a single network created in Amazon Web Services TNB
/// that can be deployed and on which life-cycle operations (like terminate,
/// update, and delete) can be performed.
pub const GetSolNetworkInstanceMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// The date that the resource was last modified.
    last_modified: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
    };
};
