/// Binds one registry to the record IDs requested from it.
pub const RegistryRecordsEntry = struct {
    /// The record IDs to retrieve from the registry. You can specify 1 through 100
    /// record IDs.
    record_ids: []const []const u8,

    /// The identifier of the registry to retrieve the records from. You can provide
    /// either the full Amazon Resource Name (ARN) or the registry ID.
    registry_id: []const u8,

    pub const json_field_names = .{
        .record_ids = "recordIds",
        .registry_id = "registryId",
    };
};
