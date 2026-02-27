/// The distribution of broker nodes across Availability Zones. This is an
/// optional parameter. If you don't specify it, Amazon MSK gives it the value
/// DEFAULT. You can also explicitly set this parameter to the value DEFAULT. No
/// other values are currently allowed.
///
/// Amazon MSK distributes the broker nodes evenly across the Availability Zones
/// that correspond to the subnets you provide when you create the cluster.
pub const BrokerAZDistribution = enum {
    default,

    pub const json_field_names = .{
        .default = "DEFAULT",
    };
};
