/// Represents an authorization for a VPC peering connection between the VPC for
/// an
/// Amazon GameLift Servers fleet and another VPC on an account you have access
/// to. This authorization
/// must exist and be valid for the peering connection to be established.
/// Authorizations are
/// valid for 24 hours after they are issued.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const VpcPeeringAuthorization = struct {
    /// Time stamp indicating when this authorization was issued. Format is a number
    /// expressed in Unix time as milliseconds (for example `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// Time stamp indicating when this authorization expires (24 hours after
    /// issuance).
    /// Format is a number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    expiration_time: ?i64 = null,

    /// A unique identifier for the Amazon Web Services account that you use to
    /// manage your Amazon GameLift Servers fleet.
    /// You can find your Account ID in the Amazon Web Services Management Console
    /// under account settings.
    game_lift_aws_account_id: ?[]const u8 = null,

    /// The authorization's peer VPC Amazon Web Services account ID.
    peer_vpc_aws_account_id: ?[]const u8 = null,

    /// A unique identifier for a VPC with resources to be accessed by your Amazon
    /// GameLift Servers fleet. The
    /// VPC must be in the same Region as your fleet. To look up a VPC ID, use the
    /// [VPC Dashboard](https://console.aws.amazon.com/vpc/) in the Amazon Web
    /// Services Management Console.
    /// Learn more about VPC peering in [VPC Peering with Amazon GameLift Servers
    /// Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).
    peer_vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .expiration_time = "ExpirationTime",
        .game_lift_aws_account_id = "GameLiftAwsAccountId",
        .peer_vpc_aws_account_id = "PeerVpcAwsAccountId",
        .peer_vpc_id = "PeerVpcId",
    };
};
