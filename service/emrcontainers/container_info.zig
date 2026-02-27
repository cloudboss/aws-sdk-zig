const EksInfo = @import("eks_info.zig").EksInfo;

/// The information about the container used for a job run or a managed
/// endpoint.
pub const ContainerInfo = union(enum) {
    /// The information about the Amazon EKS cluster.
    eks_info: ?EksInfo,

    pub const json_field_names = .{
        .eks_info = "eksInfo",
    };
};
