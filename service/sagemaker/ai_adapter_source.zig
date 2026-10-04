const AIAdapterModelPackageEntry = @import("ai_adapter_model_package_entry.zig").AIAdapterModelPackageEntry;
const AIAdapterS3Entry = @import("ai_adapter_s3_entry.zig").AIAdapterS3Entry;

/// The source of LoRA adapters for an AI recommendation job. This is a union
/// type — specify exactly one of the members.
pub const AIAdapterSource = union(enum) {
    /// A list of LoRA adapters identified by their model package ARNs. Use this
    /// when your adapters were produced by a SageMaker AI fine-tuning workflow that
    /// registers model packages.
    model_package_arns: ?[]const AIAdapterModelPackageEntry,
    /// A list of LoRA adapters identified by their Amazon S3 URIs. Use this when
    /// your adapters are stored as raw artifacts in Amazon S3.
    s3_uris: ?[]const AIAdapterS3Entry,

    pub const json_field_names = .{
        .model_package_arns = "ModelPackageArns",
        .s3_uris = "S3Uris",
    };
};
