/// The attributes required to configure and create an elastic channel. An
/// elastic channel can support a maximum of 1-million members.
pub const ElasticChannelConfiguration = struct {
    /// The maximum number of SubChannels that you want to allow in the elastic
    /// channel.
    maximum_sub_channels: i32,

    /// The minimum allowed percentage of TargetMembershipsPerSubChannel users. Ceil
    /// of the calculated value is used in balancing members among SubChannels of
    /// the elastic channel.
    minimum_membership_percentage: i32,

    /// The maximum number of members allowed in a SubChannel.
    target_memberships_per_sub_channel: i32,

    pub const json_field_names = .{
        .maximum_sub_channels = "MaximumSubChannels",
        .minimum_membership_percentage = "MinimumMembershipPercentage",
        .target_memberships_per_sub_channel = "TargetMembershipsPerSubChannel",
    };
};
