const NamespaceStatus = @import("namespace_status.zig").NamespaceStatus;
const IdentityStore = @import("identity_store.zig").IdentityStore;
const NamespaceError = @import("namespace_error.zig").NamespaceError;

/// The error type.
pub const NamespaceInfoV2 = struct {
    /// The namespace ARN.
    arn: ?[]const u8 = null,

    /// The namespace Amazon Web Services Region.
    capacity_region: ?[]const u8 = null,

    /// The creation status of a namespace that is not yet completely created.
    creation_status: ?NamespaceStatus = null,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center application.
    iam_identity_center_application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center instance.
    iam_identity_center_instance_arn: ?[]const u8 = null,

    /// The identity store used for the namespace.
    identity_store: ?IdentityStore = null,

    /// The name of the error.
    name: ?[]const u8 = null,

    /// An error that occurred when the namespace was created.
    namespace_error: ?NamespaceError = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .capacity_region = "CapacityRegion",
        .creation_status = "CreationStatus",
        .iam_identity_center_application_arn = "IamIdentityCenterApplicationArn",
        .iam_identity_center_instance_arn = "IamIdentityCenterInstanceArn",
        .identity_store = "IdentityStore",
        .name = "Name",
        .namespace_error = "NamespaceError",
    };
};
