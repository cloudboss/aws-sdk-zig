const InclusionAnnotationValue = @import("inclusion_annotation_value.zig").InclusionAnnotationValue;

/// A timestamped inclusion annotation.
pub const TimestampedInclusionAnnotation = struct {
    /// The timestamp when the inclusion annotation was last modified.
    last_modified_on: ?i64,

    /// The inclusion annotation value.
    value: ?InclusionAnnotationValue,

    pub const json_field_names = .{
        .last_modified_on = "LastModifiedOn",
        .value = "Value",
    };
};
