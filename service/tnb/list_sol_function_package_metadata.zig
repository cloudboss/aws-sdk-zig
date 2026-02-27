/// Details for the function package metadata.
///
/// A function package is a .zip file in CSAR (Cloud Service Archive) format
/// that contains a network function (an ETSI standard telecommunication
/// application) and function package descriptor that uses the TOSCA standard to
/// describe how the network functions should run on your network.
pub const ListSolFunctionPackageMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// The date that the resource was last modified.
    last_modified: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
    };
};
