/// The pod garbage collection controller configuration for the Kubernetes
/// controller manager.
pub const PodGcControllerConfigResponse = struct {
    /// The number of terminated pods that can exist before the garbage collector
    /// starts deleting them.
    terminated_pod_gc_threshold: ?i32 = null,

    pub const json_field_names = .{
        .terminated_pod_gc_threshold = "terminatedPodGcThreshold",
    };
};
