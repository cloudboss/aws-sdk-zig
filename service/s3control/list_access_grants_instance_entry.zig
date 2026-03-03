/// Information about the S3 Access Grants instance.
pub const ListAccessGrantsInstanceEntry = struct {
    /// The Amazon Resource Name (ARN) of the S3 Access Grants instance.
    access_grants_instance_arn: ?[]const u8 = null,

    /// The ID of the S3 Access Grants instance. The ID is `default`. You can have
    /// one S3 Access Grants instance per Region per account.
    access_grants_instance_id: ?[]const u8 = null,

    /// The date and time when you created the S3 Access Grants instance.
    created_at: ?i64 = null,

    /// If you associated your S3 Access Grants instance with an Amazon Web Services
    /// IAM Identity Center instance, this field returns the Amazon Resource Name
    /// (ARN) of the IAM Identity Center instance application; a subresource of the
    /// original Identity Center instance. S3 Access Grants creates this Identity
    /// Center application for the specific S3 Access Grants instance.
    identity_center_application_arn: ?[]const u8 = null,

    /// If you associated your S3 Access Grants instance with an Amazon Web Services
    /// IAM Identity Center instance, this field returns the Amazon Resource Name
    /// (ARN) of the IAM Identity Center instance application; a subresource of the
    /// original Identity Center instance. S3 Access Grants creates this Identity
    /// Center application for the specific S3 Access Grants instance.
    identity_center_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services IAM Identity
    /// Center instance that you are associating with your S3 Access Grants
    /// instance. An IAM Identity Center instance is your corporate identity
    /// directory that you added to the IAM Identity Center. You can use the
    /// [ListInstances](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListInstances.html) API operation to retrieve a list of your Identity Center instances and their ARNs.
    identity_center_instance_arn: ?[]const u8 = null,
};
