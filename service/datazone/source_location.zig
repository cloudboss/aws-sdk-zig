const S3FilesLocation = @import("s3_files_location.zig").S3FilesLocation;

/// The source location for a notebook import in Amazon SageMaker Unified
/// Studio.
pub const SourceLocation = union(enum) {
    /// The Amazon Simple Storage Service URI of the notebook source file.
    s_3: ?[]const u8,
    /// The Amazon Simple Storage Service objects to import as the notebook's cells.
    /// One cell is created for each object, in the order in which you list them.
    s_3_files: ?S3FilesLocation,

    pub const json_field_names = .{
        .s_3 = "s3",
        .s_3_files = "s3Files",
    };
};
