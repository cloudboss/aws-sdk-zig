const AIModelSourceS3 = @import("ai_model_source_s3.zig").AIModelSourceS3;

/// The source of the model for an AI recommendation job. This is a union type.
pub const AIModelSource = union(enum) {
    /// The Amazon S3 location of the model artifacts.
    s3: ?AIModelSourceS3,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
