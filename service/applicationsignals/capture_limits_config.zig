/// Guardrails that prevent instrumentation from impacting application
/// performance by limiting how much data is captured.
pub const CaptureLimitsConfig = struct {
    /// The maximum nesting depth to traverse inside collections. Defaults to 3.
    max_collection_depth: ?i32 = null,

    /// The maximum number of items to capture from any collection to prevent large
    /// payloads. Defaults to 10.
    max_collection_width: ?i32 = null,

    /// The maximum number of fields to capture for any object. Defaults to 10.
    max_fields_per_object: ?i32 = null,

    /// The maximum number of times the instrumentation point can be hit before it
    /// is automatically disabled. Defaults to 100.
    max_hits: ?i32 = null,

    /// The maximum depth for nested object traversal when capturing structured
    /// data. Defaults to 3.
    max_object_depth: ?i32 = null,

    /// The maximum number of stack frames to capture in stack traces. Defaults to
    /// 2.
    max_stack_frames: ?i32 = null,

    /// The maximum total size, in bytes, of a captured stack trace. Defaults to
    /// 1000.
    max_stack_trace_size: ?i32 = null,

    /// The maximum length of captured string values in characters. Strings longer
    /// than this are truncated. Defaults to 128.
    max_string_length: ?i32 = null,

    pub const json_field_names = .{
        .max_collection_depth = "MaxCollectionDepth",
        .max_collection_width = "MaxCollectionWidth",
        .max_fields_per_object = "MaxFieldsPerObject",
        .max_hits = "MaxHits",
        .max_object_depth = "MaxObjectDepth",
        .max_stack_frames = "MaxStackFrames",
        .max_stack_trace_size = "MaxStackTraceSize",
        .max_string_length = "MaxStringLength",
    };
};
