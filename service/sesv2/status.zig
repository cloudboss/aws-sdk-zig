/// The status of the multi-region endpoint (global-endpoint).
///
/// * `CREATING` – The resource is being provisioned.
///
/// * `READY` – The resource is ready to use.
///
/// * `FAILED` – The resource failed to be provisioned.
///
/// * `DELETING` – The resource is being deleted as requested.
pub const Status = enum {
    creating,
    ready,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready = "READY",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
