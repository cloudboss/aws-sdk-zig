/// A resource catalog containing all of the resources of a specific resource
/// type within a resource owner account. For an example on sharing the Amazon
/// SageMaker Feature Store `DefaultFeatureGroupCatalog`, see [Share Amazon
/// SageMaker Catalog resource
/// type](https://docs.aws.amazon.com/sagemaker/latest/APIReference/feature-store-cross-account-discoverability-share-sagemaker-catalog.html) in the Amazon SageMaker Developer Guide.
pub const ResourceCatalog = struct {
    /// The time the `ResourceCatalog` was created.
    creation_time: i64,

    /// A free form description of the `ResourceCatalog`.
    description: []const u8,

    /// The Amazon Resource Name (ARN) of the `ResourceCatalog`.
    resource_catalog_arn: []const u8,

    /// The name of the `ResourceCatalog`.
    resource_catalog_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .resource_catalog_arn = "ResourceCatalogArn",
        .resource_catalog_name = "ResourceCatalogName",
    };
};
