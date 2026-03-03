/// Information about an Elastic Load Balancing resource limit for your AWS
/// account.
pub const Limit = struct {
    /// The maximum value of the limit.
    max: ?[]const u8 = null,

    /// The name of the limit. The possible values are:
    ///
    /// * classic-listeners
    ///
    /// * classic-load-balancers
    ///
    /// * classic-registered-instances
    name: ?[]const u8 = null,
};
