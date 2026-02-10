const ImageState = @import("image_state.zig").ImageState;

/// Information about the AMI.
pub const ImageMetadata = struct {
    /// The date and time the AMI was created.
    creation_date: ?[]const u8,

    /// The deprecation date and time of the AMI, in UTC, in the following format:
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z.
    deprecation_time: ?[]const u8,

    /// If `true`, the AMI satisfies the criteria for Allowed AMIs and can be
    /// discovered and used in the account. If `false`, the AMI can't be discovered
    /// or used
    /// in the account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    image_allowed: ?bool,

    /// The ID of the AMI.
    image_id: ?[]const u8,

    /// The alias of the AMI owner.
    ///
    /// Valid values: `amazon` | `aws-backup-vault` |
    /// `aws-marketplace`
    image_owner_alias: ?[]const u8,

    /// Indicates whether the AMI has public launch permissions. A value of `true`
    /// means this AMI has public launch permissions, while `false` means it has
    /// only
    /// implicit (AMI owner) or explicit (shared with your account) launch
    /// permissions.
    is_public: ?bool,

    /// The name of the AMI.
    name: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the AMI.
    owner_id: ?[]const u8,

    /// The current state of the AMI. If the state is `available`, the AMI is
    /// successfully registered and can be used to launch an instance.
    state: ?ImageState,
};
