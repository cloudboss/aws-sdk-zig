const InstanceStatus = @import("instance_status.zig").InstanceStatus;

/// Provides information about the IAM Identity Center instance.
pub const InstanceMetadata = struct {
    /// The date and time that the Identity Center instance was created.
    created_date: ?i64 = null,

    /// The identifier of the identity store that is connected to the Identity
    /// Center instance.
    identity_store_id: ?[]const u8 = null,

    /// The ARN of the Identity Center instance under which the operation will be
    /// executed. For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// The name of the Identity Center instance.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID number of the owner of the Identity
    /// Center instance.
    owner_account_id: ?[]const u8 = null,

    /// The current status of this Identity Center instance.
    status: ?InstanceStatus = null,

    /// Provides additional context about the current status of the IAM Identity
    /// Center instance. This field is particularly useful when an instance is in a
    /// non-ACTIVE state, such as CREATE_FAILED. When an instance creation fails,
    /// this field contains information about the cause, which may include issues
    /// with KMS key configuration or insufficient permissions.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .identity_store_id = "IdentityStoreId",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
