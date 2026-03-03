const GetSolVnfcResourceInfoMetadata = @import("get_sol_vnfc_resource_info_metadata.zig").GetSolVnfcResourceInfoMetadata;

/// Details of resource associated with a network function.
///
/// A network instance is a single network created in Amazon Web Services TNB
/// that can be deployed and on which life-cycle operations (like terminate,
/// update, and delete) can be performed.
pub const GetSolVnfcResourceInfo = struct {
    /// The metadata of the network function compute.
    metadata: ?GetSolVnfcResourceInfoMetadata = null,

    pub const json_field_names = .{
        .metadata = "metadata",
    };
};
