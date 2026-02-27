const AnnotationValue = @import("annotation_value.zig").AnnotationValue;
const ServiceId = @import("service_id.zig").ServiceId;

/// Information about a segment annotation.
pub const ValueWithServiceIds = struct {
    /// Values of the annotation.
    annotation_value: ?AnnotationValue,

    /// Services to which the annotation applies.
    service_ids: ?[]const ServiceId,

    pub const json_field_names = .{
        .annotation_value = "AnnotationValue",
        .service_ids = "ServiceIds",
    };
};
