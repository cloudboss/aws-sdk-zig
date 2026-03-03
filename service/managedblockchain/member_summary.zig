const MemberStatus = @import("member_status.zig").MemberStatus;

/// A summary of configuration properties for a member.
///
/// Applies only to Hyperledger Fabric.
pub const MemberSummary = struct {
    /// The Amazon Resource Name (ARN) of the member. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The date and time that the member was created.
    creation_date: ?i64 = null,

    /// An optional description of the member.
    description: ?[]const u8 = null,

    /// The unique identifier of the member.
    id: ?[]const u8 = null,

    /// An indicator of whether the member is owned by your Amazon Web Services
    /// account or a different Amazon Web Services account.
    is_owned: ?bool = null,

    /// The name of the member.
    name: ?[]const u8 = null,

    /// The status of the member.
    ///
    /// * `CREATING` - The Amazon Web Services account is in the process of creating
    ///   a member.
    ///
    /// * `AVAILABLE` - The member has been created and can participate in the
    ///   network.
    ///
    /// * `CREATE_FAILED` - The Amazon Web Services account attempted to create a
    ///   member and creation failed.
    ///
    /// * `UPDATING` - The member is in the process of being updated.
    ///
    /// * `DELETING` - The member and all associated resources are in the process of
    ///   being deleted. Either the Amazon Web Services account that owns the member
    ///   deleted it, or the member is being deleted as the result of an `APPROVED`
    /// `PROPOSAL` to remove the member.
    ///
    /// * `DELETED` - The member can no longer participate on the network and all
    ///   associated resources are deleted. Either the Amazon Web Services account
    ///   that owns the member deleted it, or the member is being deleted as the
    ///   result of an `APPROVED`
    /// `PROPOSAL` to remove the member.
    ///
    /// * `INACCESSIBLE_ENCRYPTION_KEY` - The member is impaired and might not
    ///   function as expected because it cannot access the specified customer
    ///   managed key in Key Management Service (KMS) for encryption at rest. Either
    ///   the KMS key was disabled or deleted, or the grants on the key were
    ///   revoked.
    ///
    /// The effect of disabling or deleting a key or of revoking a grant isn't
    /// immediate. It might take some time for the member resource to discover that
    /// the key is inaccessible. When a resource is in this state, we recommend
    /// deleting and recreating the resource.
    status: ?MemberStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .id = "Id",
        .is_owned = "IsOwned",
        .name = "Name",
        .status = "Status",
    };
};
