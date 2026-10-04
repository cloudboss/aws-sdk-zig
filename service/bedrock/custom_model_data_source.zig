const ModelPackageArnDataSource = @import("model_package_arn_data_source.zig").ModelPackageArnDataSource;

/// The data source for a custom model. This is a union type that supports the
/// following member:
///
/// * `modelPackageArnDataSource` — Specifies a SageMaker AI model package as
///   the data source.
pub const CustomModelDataSource = union(enum) {
    /// A SageMaker AI model package ARN as the data source for the custom model.
    /// When you specify a model package ARN, Amazon Bedrock resolves the model
    /// package to retrieve the model artifacts.
    model_package_arn_data_source: ?ModelPackageArnDataSource,

    pub const json_field_names = .{
        .model_package_arn_data_source = "modelPackageArnDataSource",
    };
};
