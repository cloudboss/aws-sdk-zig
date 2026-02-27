pub const ShareResourceType = enum {
    /// The share is on a variant store
    variant_store,
    /// The share is on an annotation store
    annotation_store,
    /// The share is on a workflow
    workflow,

    pub const json_field_names = .{
        .variant_store = "VARIANT_STORE",
        .annotation_store = "ANNOTATION_STORE",
        .workflow = "WORKFLOW",
    };
};
