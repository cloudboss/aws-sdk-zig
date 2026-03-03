/// Provides execution parameters for the inference container.
pub const InferenceContainerExecutionParameters = struct {
    /// The maximum size of the inference container payload, specified in MB.
    max_payload_in_mb: ?i32 = null,

    pub const json_field_names = .{
        .max_payload_in_mb = "maxPayloadInMB",
    };
};
