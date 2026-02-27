const Permission = @import("permission.zig").Permission;

/// Part of `ListCallerAccessGrantsResult`. Each entry includes the
/// permission level (READ, WRITE, or READWRITE) and the grant scope of the
/// access grant. If the grant also includes an application ARN, the grantee can
/// only access the S3 data through this application.
pub const ListCallerAccessGrantsEntry = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services IAM Identity Center
    /// application associated with your Identity Center instance. If the grant
    /// includes an application ARN, the grantee can only access the S3 data through
    /// this application.
    application_arn: ?[]const u8,

    /// The S3 path of the data to which you have been granted access.
    grant_scope: ?[]const u8,

    /// The type of permission granted, which can be one of the following values:
    ///
    /// * `READ` - Grants read-only access to the S3 data.
    ///
    /// * `WRITE` - Grants write-only access to the S3 data.
    ///
    /// * `READWRITE` - Grants both read and write access to the S3 data.
    permission: ?Permission,
};
