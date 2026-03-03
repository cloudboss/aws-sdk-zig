const ELBInfo = @import("elb_info.zig").ELBInfo;
const TargetGroupInfo = @import("target_group_info.zig").TargetGroupInfo;
const TargetGroupPairInfo = @import("target_group_pair_info.zig").TargetGroupPairInfo;

/// Information about the Elastic Load Balancing load balancer or target group
/// used in a
/// deployment.
///
/// You can use load balancers and target groups in combination. For example, if
/// you have
/// two Classic Load Balancers, and five target groups tied to an Application
/// Load Balancer,
/// you can specify the two Classic Load Balancers in `elbInfoList`, and the
/// five
/// target groups in `targetGroupInfoList`.
pub const LoadBalancerInfo = struct {
    /// An array that contains information about the load balancers to use for load
    /// balancing
    /// in a deployment. If you're using Classic Load Balancers, specify those load
    /// balancers in
    /// this array.
    ///
    /// You can add up to 10 load balancers to the array.
    ///
    /// If you're using Application Load Balancers or Network Load Balancers, use
    /// the
    /// `targetGroupInfoList` array instead of this one.
    elb_info_list: ?[]const ELBInfo = null,

    /// An array that contains information about the target groups to use for load
    /// balancing
    /// in a deployment. If you're using Application Load Balancers and Network Load
    /// Balancers,
    /// specify their associated target groups in this array.
    ///
    /// You can add up to 10 target groups to the array.
    ///
    /// If you're using Classic Load Balancers, use the `elbInfoList` array
    /// instead of this one.
    target_group_info_list: ?[]const TargetGroupInfo = null,

    /// The target group pair information. This is an array of
    /// `TargeGroupPairInfo` objects with a maximum size of one.
    target_group_pair_info_list: ?[]const TargetGroupPairInfo = null,

    pub const json_field_names = .{
        .elb_info_list = "elbInfoList",
        .target_group_info_list = "targetGroupInfoList",
        .target_group_pair_info_list = "targetGroupPairInfoList",
    };
};
