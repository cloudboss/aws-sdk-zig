const AnnotationSeverityLevel = @import("annotation_severity_level.zig").AnnotationSeverityLevel;
const AnnotationStatus = @import("annotation_status.zig").AnnotationStatus;

/// The `Annotation` data type.
///
/// A `GetHookResult` call returns detailed information and remediation guidance
/// from
/// Control Tower, Guard, Lambda, or custom Hooks for a Hook invocation result.
pub const Annotation = struct {
    /// An identifier for the evaluation logic that was used when invoking the Hook.
    /// For Control Tower,
    /// this is the control ID. For Guard, this is the rule ID. For Lambda and
    /// custom Hooks,
    /// this is a user-defined identifier.
    annotation_name: ?[]const u8 = null,

    /// A URL that you can access for additional remediation guidance.
    remediation_link: ?[]const u8 = null,

    /// Suggests what to change if your Hook returns a `FAILED` status. For example,
    /// "Block public access to the bucket".
    remediation_message: ?[]const u8 = null,

    /// The relative risk associated with any violations of this type.
    severity_level: ?AnnotationSeverityLevel = null,

    /// The status of the Hook invocation from the downstream service.
    status: ?AnnotationStatus = null,

    /// The explanation for the specific status assigned to this Hook invocation.
    /// For example,
    /// "Bucket does not block public access".
    status_message: ?[]const u8 = null,
};
