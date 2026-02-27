/// The data store request.
pub const DataStoreRequest = struct {
    /// Enabled: Set to true to enabled data store for this domain.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
