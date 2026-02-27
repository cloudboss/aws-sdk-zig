/// The properties that are applied when Salesforce is being used as a source.
pub const SalesforceSourceProperties = struct {
    /// The flag that enables dynamic fetching of new (recently added) fields in the
    /// Salesforce
    /// objects while running a flow.
    enable_dynamic_field_update: bool = false,

    /// Indicates whether Amazon AppFlow includes deleted files in the flow run.
    include_deleted_records: bool = false,

    /// The object specified in the Salesforce flow source.
    object: []const u8,

    pub const json_field_names = .{
        .enable_dynamic_field_update = "EnableDynamicFieldUpdate",
        .include_deleted_records = "IncludeDeletedRecords",
        .object = "Object",
    };
};
