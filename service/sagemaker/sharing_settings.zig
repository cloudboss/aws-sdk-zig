const NotebookOutputOption = @import("notebook_output_option.zig").NotebookOutputOption;

/// Specifies options for sharing Amazon SageMaker AI Studio notebooks. These
/// settings are specified as part of `DefaultUserSettings` when the
/// `CreateDomain` API is called, and as part of `UserSettings` when the
/// `CreateUserProfile` API is called. When `SharingSettings` is not specified,
/// notebook sharing isn't allowed.
pub const SharingSettings = struct {
    /// Whether to include the notebook cell output when sharing the notebook. The
    /// default is `Disabled`.
    notebook_output_option: ?NotebookOutputOption = null,

    /// When `NotebookOutputOption` is `Allowed`, the Amazon Web Services Key
    /// Management Service (KMS) encryption key ID used to encrypt the notebook cell
    /// output in the Amazon S3 bucket.
    s3_kms_key_id: ?[]const u8 = null,

    /// When `NotebookOutputOption` is `Allowed`, the Amazon S3 bucket used to store
    /// the shared notebook snapshots.
    s3_output_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .notebook_output_option = "NotebookOutputOption",
        .s3_kms_key_id = "S3KmsKeyId",
        .s3_output_path = "S3OutputPath",
    };
};
