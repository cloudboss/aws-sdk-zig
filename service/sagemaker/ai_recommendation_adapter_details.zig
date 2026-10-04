const AIAdapterModelPackageEntry = @import("ai_adapter_model_package_entry.zig").AIAdapterModelPackageEntry;
const AIAdapterS3Entry = @import("ai_adapter_s3_entry.zig").AIAdapterS3Entry;

/// The per-recommendation LoRA adapter details. Contains both the model package
/// ARNs and Amazon S3 URIs for each adapter, regardless of which form was
/// originally supplied in the request. When you supply only Amazon S3 URIs,
/// Amazon SageMaker AI creates model packages on your behalf.
pub const AIRecommendationAdapterDetails = struct {
    /// The list of LoRA adapters with their model package ARNs.
    model_package_arns: []const AIAdapterModelPackageEntry,

    /// The list of LoRA adapters with their Amazon S3 URIs.
    s3_uris: []const AIAdapterS3Entry,

    pub const json_field_names = .{
        .model_package_arns = "ModelPackageArns",
        .s3_uris = "S3Uris",
    };
};
