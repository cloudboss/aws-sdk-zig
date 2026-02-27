const IdentitySourceParametersForList = @import("identity_source_parameters_for_list.zig").IdentitySourceParametersForList;
const IdentitySourceType = @import("identity_source_type.zig").IdentitySourceType;
const IdentitySourceStatus = @import("identity_source_status.zig").IdentitySourceStatus;
const IdentitySourceStatusCode = @import("identity_source_status_code.zig").IdentitySourceStatusCode;

/// Contains details for an identity source. For more information, see [Identity
/// source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
/// in the *Multi-party approval User Guide*.
pub const IdentitySourceForList = struct {
    /// Timestamp when the identity source was created.
    creation_time: ?i64,

    /// Amazon Resource Name (ARN) for the identity source.
    identity_source_arn: ?[]const u8,

    /// A `IdentitySourceParametersForList` object. Contains details for the
    /// resource that provides identities to the identity source. For example, an
    /// IAM Identity Center instance.
    identity_source_parameters: ?IdentitySourceParametersForList,

    /// The type of resource that provided identities to the identity source. For
    /// example, an IAM Identity Center instance.
    identity_source_type: ?IdentitySourceType,

    /// Status for the identity source. For example, if the identity source is
    /// `ACTIVE`.
    status: ?IdentitySourceStatus,

    /// Status code of the identity source.
    status_code: ?IdentitySourceStatusCode,

    /// Message describing the status for the identity source.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .identity_source_arn = "IdentitySourceArn",
        .identity_source_parameters = "IdentitySourceParameters",
        .identity_source_type = "IdentitySourceType",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};
