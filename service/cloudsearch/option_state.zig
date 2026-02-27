/// The state of processing a change to an option. One of:
///
/// * RequiresIndexDocuments: The option's latest value will not be deployed
///   until IndexDocuments has been called and indexing is complete.
///
/// * Processing: The option's latest value is in the process of being
///   activated.
///
/// * Active: The option's latest value is fully deployed.
///
/// * FailedToValidate: The option value is not compatible with the domain's
///   data and cannot be used to index the data. You must either modify the
///   option value or update or remove the incompatible documents.
pub const OptionState = enum {
    requires_index_documents,
    processing,
    active,
    failed_to_validate,
};
