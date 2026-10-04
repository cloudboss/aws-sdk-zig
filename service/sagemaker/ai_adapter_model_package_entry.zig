/// A LoRA adapter entry identified by a model package ARN.
pub const AIAdapterModelPackageEntry = struct {
    /// A unique identifier for the adapter. This ID is used as the inference
    /// component name when the adapter is deployed. The ID must start and end with
    /// an alphanumeric character, can contain hyphens between alphanumeric
    /// characters, and can be up to 63 characters long.
    adapter_id: []const u8,

    /// The Amazon Resource Name (ARN) of the model package that contains the LoRA
    /// adapter artifacts.
    model_package_arn: []const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .model_package_arn = "ModelPackageArn",
    };
};
