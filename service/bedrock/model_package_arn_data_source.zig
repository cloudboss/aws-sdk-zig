/// Contains the Amazon Resource Name (ARN) of a SageMaker AI model package to
/// use as the data source for a custom model.
pub const ModelPackageArnDataSource = struct {
    /// The Amazon Resource Name (ARN) of the SageMaker AI model package. The ARN
    /// must be for a model package of `restricted` type.
    ///
    /// To use a model package ARN, you must have the
    /// `sagemaker:DescribeModelPackage` and `sagemaker:AccessModelPackageData`
    /// permissions on the model package resource.
    model_package_arn: []const u8,

    pub const json_field_names = .{
        .model_package_arn = "modelPackageArn",
    };
};
