/// The source location for a notebook import in Amazon SageMaker Unified
/// Studio.
pub const SourceLocation = union(enum) {
    /// The Amazon Simple Storage Service URI of the notebook source file.
    s_3: ?[]const u8,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
