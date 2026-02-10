/// Describes a security group and Amazon Web Services account ID pair.
pub const UserIdGroupPair = struct {
    /// A description for the security group rule that references this user ID group
    /// pair.
    ///
    /// Constraints: Up to 255 characters in length. Allowed characters are a-z,
    /// A-Z, 0-9,
    /// spaces, and ._-:/()#,@[]+=;{}!$*
    description: ?[]const u8,

    /// The ID of the security group.
    group_id: ?[]const u8,

    /// [Default VPC] The name of the security group. For a security group in a
    /// nondefault VPC,
    /// use the security group ID.
    ///
    /// For a referenced security group in another VPC, this value is not returned
    /// if the
    /// referenced security group is deleted.
    group_name: ?[]const u8,

    /// The status of a VPC peering connection, if applicable.
    peering_status: ?[]const u8,

    /// The ID of an Amazon Web Services account.
    ///
    /// For a referenced security group in another VPC, the account ID of the
    /// referenced
    /// security group is returned in the response. If the referenced security group
    /// is deleted,
    /// this value is not returned.
    user_id: ?[]const u8,

    /// The ID of the VPC for the referenced security group, if applicable.
    vpc_id: ?[]const u8,

    /// The ID of the VPC peering connection, if applicable.
    vpc_peering_connection_id: ?[]const u8,
};
