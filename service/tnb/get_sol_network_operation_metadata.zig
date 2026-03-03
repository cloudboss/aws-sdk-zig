const InstantiateMetadata = @import("instantiate_metadata.zig").InstantiateMetadata;
const ModifyVnfInfoMetadata = @import("modify_vnf_info_metadata.zig").ModifyVnfInfoMetadata;
const UpdateNsMetadata = @import("update_ns_metadata.zig").UpdateNsMetadata;

/// Metadata related to a network operation occurrence.
///
/// A network operation is any operation that is done to your network, such as
/// network instance instantiation or termination.
pub const GetSolNetworkOperationMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// Metadata related to the network operation occurrence for network
    /// instantiation.
    /// This is populated only if the lcmOperationType is `INSTANTIATE`.
    instantiate_metadata: ?InstantiateMetadata = null,

    /// The date that the resource was last modified.
    last_modified: i64,

    /// Metadata related to the network operation occurrence for network function
    /// updates in a network instance.
    /// This is populated only if the lcmOperationType is `UPDATE` and the
    /// updateType is `MODIFY_VNF_INFORMATION`.
    modify_vnf_info_metadata: ?ModifyVnfInfoMetadata = null,

    /// Metadata related to the network operation occurrence for network instance
    /// updates.
    /// This is populated only if the lcmOperationType is `UPDATE` and the
    /// updateType is `UPDATE_NS`.
    update_ns_metadata: ?UpdateNsMetadata = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .instantiate_metadata = "instantiateMetadata",
        .last_modified = "lastModified",
        .modify_vnf_info_metadata = "modifyVnfInfoMetadata",
        .update_ns_metadata = "updateNsMetadata",
    };
};
