/// The state of a requested change. One of the following:
///
/// * Processing: The request change is still in-process.
///
/// * Active: The request change is processed and deployed to the Elasticsearch
///   domain.
pub const OptionState = enum {
    requires_index_documents,
    processing,
    active,

    pub const json_field_names = .{
        .requires_index_documents = "RequiresIndexDocuments",
        .processing = "Processing",
        .active = "Active",
    };
};
