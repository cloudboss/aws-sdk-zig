const S3ObjectSource = @import("s3_object_source.zig").S3ObjectSource;

/// Template version source data.
pub const TemplateVersionSourceInput = union(enum) {
    /// An S3 source object that includes the template bundle S3 path and name for a
    /// template minor version.
    s_3: ?S3ObjectSource,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
