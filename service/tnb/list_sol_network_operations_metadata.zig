/// Metadata related to a network operation.
///
/// A network operation is any operation that is done to your network, such as
/// network instance instantiation or termination.
pub const ListSolNetworkOperationsMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// The date that the resource was last modified.
    last_modified: i64,

    /// The network service descriptor id used for the operation.
    ///
    /// Only present if the updateType is `UPDATE_NS`.
    nsd_info_id: ?[]const u8 = null,

    /// The network function id used for the operation.
    ///
    /// Only present if the updateType is `MODIFY_VNF_INFO`.
    vnf_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
        .nsd_info_id = "nsdInfoId",
        .vnf_instance_id = "vnfInstanceId",
    };
};
