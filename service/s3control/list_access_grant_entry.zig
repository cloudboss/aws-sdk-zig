const AccessGrantsLocationConfiguration = @import("access_grants_location_configuration.zig").AccessGrantsLocationConfiguration;
const Grantee = @import("grantee.zig").Grantee;
const Permission = @import("permission.zig").Permission;

/// Information about the access grant.
pub const ListAccessGrantEntry = struct {
    /// The Amazon Resource Name (ARN) of the access grant.
    access_grant_arn: ?[]const u8 = null,

    /// The ID of the access grant. S3 Access Grants auto-generates this ID when you
    /// create the access grant.
    access_grant_id: ?[]const u8 = null,

    /// The configuration options of the grant location. The grant location is the
    /// S3 path to the data to which you are granting access.
    access_grants_location_configuration: ?AccessGrantsLocationConfiguration = null,

    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigns this ID when you register the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    access_grants_location_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an Amazon Web Services IAM Identity Center
    /// application associated with your Identity Center instance. If the grant
    /// includes an application ARN, the grantee can only access the S3 data through
    /// this application.
    application_arn: ?[]const u8 = null,

    /// The date and time when you created the S3 Access Grants instance.
    created_at: ?i64 = null,

    /// The user, group, or role to which you are granting access. You can grant
    /// access to an IAM user or role. If you have added your corporate directory to
    /// Amazon Web Services IAM Identity Center and associated your Identity Center
    /// instance with your S3 Access Grants instance, the grantee can also be a
    /// corporate directory user or group.
    grantee: ?Grantee = null,

    /// The S3 path of the data to which you are granting access. It is the result
    /// of appending the `Subprefix` to the location scope.
    grant_scope: ?[]const u8 = null,

    /// The type of access granted to your S3 data, which can be set to one of the
    /// following values:
    ///
    /// * `READ` – Grant read-only access to the S3 data.
    ///
    /// * `WRITE` – Grant write-only access to the S3 data.
    ///
    /// * `READWRITE` – Grant both read and write access to the S3 data.
    permission: ?Permission = null,
};
